//
//  APIRouter.swift
//  WithYou
//
//  Created by Ahmed Raslan on 05/09/2023.
//

import Alamofire



typealias RequestMethod = HTTPMethod

protocol APIRouter: URLRequestConvertible {
    var baseURL: String {get}
    var method: RequestMethod {get}
    var path: String {get}
    var queries: APIParameters? {get}
    var body: APIParameters? {get}
    func send<T:Codable> (data: [UploadData]?, dataType: T.Type) async throws -> BaseResponse<T>
}

extension APIRouter {
    
    var baseURL: String {
        return "https://amin-services.com/api/"
    }
    
    //MARK: - Create Request -
    func asURLRequest() throws -> URLRequest {
        
        //MARK: - URL -
        var urlRequest = URLRequest(url: try baseURL.asURL().appendingPathComponent(path))
        
        //MARK: - HTTTP Method -
        urlRequest.httpMethod = method.rawValue
        
        //MARK: - Common Headers -
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(Language.apiLanguage(), forHTTPHeaderField: "lang")
        
        //MARK: - Token -
        if let token = UserDefaults.accessToken?.trimWhiteSpace(), !token.isEmpty {
            urlRequest.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //MARK: - Parameters -
        if let queries = queries?.compactMapValues({$0}) {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: queries)
        }
        if let body = body?.compactMapValues({$0}) {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        }
        
        //MARK: - All Request data
        print(
              """
              
              ====================================
              🚀🚀FULL REQUEST COMPONENETS:::
              
              URL:: \(urlRequest.url?.absoluteString ?? "No URL Found")
              ---------------------------------
              Method:: \(urlRequest.httpMethod ?? "No httpMethod")
              ---------------------------------
              Header::
              \((urlRequest.allHTTPHeaderFields ?? [:]).json())
              ---------------------------------
              Queries::
              \((queries?.compactMapValues({$0}) ?? [:]).json())
              ---------------------------------
              Body::
              \((body?.compactMapValues({$0}) ?? [:]).json())
              
              ====================================
              
              """
        )
        
        return urlRequest
    }
    
    //MARK: - Send Request -
    func send<T:Codable> (data: [UploadData]? = nil, dataType: T.Type) async throws -> BaseResponse<T> {
        guard let data else {
            print(data as Any)
            return try await self.sendRequest(using: T.self)
        }
 
        return try await self.uploadToServer(data: data, using: T.self)
    }
    
    
    private func sendRequest<T>(using response: T.Type) async throws -> BaseResponse<T> {
        
        return try await withCheckedThrowingContinuation{ continuation in
            AF.request(self).responseData { response in
                
                
                self.printApiResponse(response.data)
                print(response.value as Any)
                switch response.result {
                case .success(let data) :
                    do {
                        let handledResponse = try ResponseHandler.default.handle(data: data, to: T.self)
                        continuation.resume(returning: handledResponse)
                        
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                case .failure:
    
                    continuation.resume(throwing: ResponseError.canNotConnectToServer)
                }
            }
        }
    }
    
    
    private func uploadToServer<T>(data: [UploadData], using response: T.Type) async throws -> BaseResponse<T> {
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                if let body = self.body?.compactMapValues({$0}) {
                    for (key, value) in body {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                }
                if let queries = self.queries?.compactMapValues({$0}) {
                    for (key, value) in queries {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                }
                for item in data {
                    print(item.nameWithExtension)
                    multipartFormData.append(item.data,
                                             withName: item.name,
                                             fileName: item.nameWithExtension,
                                             mimeType: item.mimeType.rawValue)
                }
                
            }, with: self).uploadProgress(closure: { (progress) in
                print("the Progress is \(Int(progress.fractionCompleted*100)) %")
            }).responseData { response in
                
                self.printApiResponse(response.data)
                
                switch response.result {
                    
                case .success(let data) :
                    do {
                        let handledResponse = try ResponseHandler.default.handle(data: data, to: T.self)
                        continuation.resume(returning: handledResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure:
                    continuation.resume(throwing: ResponseError.canNotConnectToServer)
                }
            }
        }
    }
    
    //MARK: - Helper Methods -
    private func printApiResponse(_ responseData: Data?) {
    #if DEBUG
        guard let responseData = responseData else {
            print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,responseData as Any, "\n====================================\n\n")
            return
        }
        
        if let object = try? JSONSerialization.jsonObject(with: responseData, options: []),
           let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys]), let JSONString = String(data: data, encoding: String.Encoding.utf8) {
            print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,JSONString, "\n====================================\n\n")
            //print(responseData)
            
            return
        }
        print("\n\n====================================\n⚡️⚡️RESPONSE IS::\n" ,responseData, "\n====================================\n\n")
    #endif
    }
    
    
}


class APIPDFService {
    static let shared = APIPDFService()
    
    func downloadPDF (url: String,completion: @escaping(_ error: Error?) -> Void) {
        let destination: DownloadRequest.Destination = { _ , _ in
            let documentURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            if url.contains("pdf"){
                let fileURL = documentURLs.appendingPathComponent("RandomFile\(Int.random(in: 1..<10000)).pdf")
            
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }else{
                let fileURL = documentURLs.appendingPathComponent("RandomFile\(Int.random(in: 1..<10000)).png")
   
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            
            
        }
        
        AF.download(URL(string: url)!, method: .get, to: destination).downloadProgress(closure: { (progress) in
            
        }).validate()
            .response {response in
                
                if response.error == nil {
                    
                    debugPrint(response)
                    completion(nil)
                }
                else {
                    completion(response.error)
                }
            }
    }
    
}



class APIImageDwonloader {
    static let shared = APIImageDwonloader()
    
    func downloadImage (url: String,completion: @escaping(_ error: Error?) -> Void) {
        
        let destination: DownloadRequest.Destination = { _ , _ in
            
            let documentURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let fileURL = documentURLs.appendingPathComponent("RandomFile\(Int.random(in: 1..<10000)).jpeg")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            
        }
        
        AF.download(URL(string: url)!, method: .get, to: destination).downloadProgress(closure: { (progress) in
            
        }).validate()
            .response {response in
                
                if response.error == nil {
                    
                    debugPrint(response)
                    completion(nil)
                }
                else {
                    completion(response.error)
                }
            }
    }
    
}

