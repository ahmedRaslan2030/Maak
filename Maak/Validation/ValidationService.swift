//
//  ValidationService.swift
//
//  Created by Ahmed Raslan®
//


import Foundation

struct ValidationService {
    
    //MARK: - Avatar -
    static func validate(avatar: Data?) throws -> Data {
        guard let avatar = avatar else {
            throw ValidationError.emptyAvatar
        }
        return avatar
    }
    
    
    //MARK: - Name -
    static func validate(firstName: String?) throws -> String {
        guard let firstName = firstName, !firstName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyFirstName
        }
        guard firstName.count > 2 else {
            throw ValidationError.shortFirstName
        }
        guard firstName.count < 61 else {
            throw ValidationError.longFirstName
        }
        return firstName
    }
    static func validate(lastName: String?) throws -> String {
        guard let lastName = lastName, !lastName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyLastName
        }
        guard lastName.count > 2 else {
            throw ValidationError.shortLastName
        }
        guard lastName.count < 61 else {
            throw ValidationError.longLastName
        }
        return lastName
    }
    static func validate(familyName: String?) throws -> String {
        guard let familyName = familyName, !familyName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyFamilyName
        }
        guard familyName.count > 2 else {
            throw ValidationError.shortFamilyName
        }
        guard familyName.count < 61 else {
            throw ValidationError.longFamilyName
        }
        return familyName
    }
    static func validate(fullName: String?) throws -> String {
        guard let fullName = fullName, !fullName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyFullName
        }
        guard fullName.count > 2 else {
            throw ValidationError.shortFullName
        }
        guard fullName.count < 61 else {
            throw ValidationError.longFullName
        }
        return fullName
    }
    
    
    
    static func validate(userName: String?) throws -> String {
        guard let userName = userName, !userName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyUserName
        }
        guard userName.count > 2 else {
            throw ValidationError.shortUserName
        }
        guard userName.count < 61 else {
            throw ValidationError.longUserName
        }
        return userName
    }
    
    
    static func validate(nationality: String?) throws -> String {
        guard let nationality = nationality, !nationality.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyNationality
        }
        return nationality
    }
    
    
    static func validate(name: String?) throws -> String {
        guard let name = name, !name.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyName
        }
        guard name.count > 2 else {
            throw ValidationError.shortName
        }
        guard name.count < 61 else {
            throw ValidationError.longName
        }
        return name
    }
    
    //MARK: - Phone -
    static func validate(phone: String?) throws -> String {
        guard let phone = phone, !phone.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPhoneNumber
        }
        guard phone.isValidPhoneNumber(pattern: RegularExpression.saudiArabiaPhone.value) else {
            throw ValidationError.incorrectPhoneNumber
        }
        return phone
    }
    

    //MARK: - Verification code -
    static func validate(verificationCode: String?) throws -> String {
        guard let verificationCode = verificationCode, !verificationCode.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyVerificationCode
        }
        guard verificationCode.count == 4 else {
            throw ValidationError.incorrectVerificationCode
        }
        return verificationCode
    }
    
    //MARK: - Email -
    static func validate(email: String?) throws -> String {
        guard let email = email, !email.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyMail
        }
        guard email.isValidEmail() else{
            throw ValidationError.wrongMail
        }
        return email
    }
    
    //MARK: - Passwords -
    static func validate(password: String?) throws -> String {
        guard let password = password, !password.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPassword
        }
        guard password.count > 5 else {
            throw ValidationError.shortPassword
        }
        return password
    }
    static func validate(newPassword: String?) throws -> String {
        guard let newPassword = newPassword, !newPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyNewPassword
        }
        guard newPassword.count > 5 else {
            throw ValidationError.shortNewPassword
        }
        return newPassword
    }
    static func validate(oldPassword: String?) throws -> String {
        guard let oldPassword = oldPassword, !oldPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyOldPassword
        }
        guard oldPassword.count > 5 else {
            throw ValidationError.shortOldPassword
        }
        return oldPassword
    }
    static func validate(newPassword: String, confirmNewPassword: String?) throws -> String {
        guard let confirmNewPassword = confirmNewPassword, !confirmNewPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyConfirmNewPassword
        }
        guard newPassword == confirmNewPassword else {
            throw ValidationError.notMatchPasswords
        }
        return newPassword
    }
    static func validate(newPassword: String, confirmPassword: String?) throws -> String {
        guard let confirmPassword = confirmPassword, !confirmPassword.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyConfirmPassword
        }
        guard newPassword == confirmPassword else {
            throw ValidationError.notMatchPasswords
        }
        return newPassword
    }
    static func validate(termsAgreed: Bool) throws {
        guard termsAgreed else {
            throw ValidationError.terms
        }
    }
    
    //MARK: - Location -
    static func validate(countryCode: String?) throws -> String {
        guard let countryCode = countryCode ,
                !countryCode.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyCountry
        }
        
        return countryCode
    }
    
    static func validate(countryId: Int?) throws -> Int {
        guard let countryId = countryId   else {
            throw ValidationError.emptyCountry
        }
        return countryId
    }
    
    
    static func validate(governorateId: Int?) throws -> Int {
        guard let governorateId = governorateId else {
            throw ValidationError.emptyGovernorate
        }
        return governorateId
    }
    
    static func validate(regionId: Int?) throws -> Int {
        guard let regionId = regionId else {
            throw ValidationError.emptyRegion
        }
        return regionId
    }
    
    
    static func validate(cityId: Int?) throws -> Int {
        guard let cityId = cityId else {
            throw ValidationError.emptyCity
        }
        return cityId
    }
    static func validate(areaId: Int?) throws -> Int {
        guard let areaId = areaId else {
            throw ValidationError.emptyArea
        }
        return areaId
    }
    static func validate(streetName: String?) throws -> String {
        guard let streetName = streetName, !streetName.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyStreet
        }
        return streetName
    }
    
    
    
    static func validate(department: String?) throws -> String {
        guard let department = department, !department.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyStreet
        }
        return department

    }
    static func validate(addressType: String?) throws -> String {
        guard let addressType = addressType, !addressType.trimWhiteSpace().isEmpty else {
            throw ValidationError.addressType
        }
        return addressType
    }
    static func validate(addressDetails: String?) throws -> String {
        guard let addressDetails = addressDetails, !addressDetails.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyAddressDetails
        }
        return addressDetails
    }
    
    static func validateLocation(address: String?, lat: Double?, long: Double?) throws -> (address: String, lat: Double, long: Double) {
        guard let address = address, let lat = lat, let long = long else {
            throw ValidationError.emptyLocation
        }
        return (address, lat, long)
    }
    
    static func validateDestinationLocation(address: String?, lat: Double?, long: Double?) throws -> (address: String, lat: Double, long: Double) {
        guard let address = address, let lat = lat, let long = long else {
            throw ValidationError.emptyLocation
        }
        return (address, lat, long)
    }
    
    //MARK: - Images -
    static func validate(profilePicture: Data?) throws -> Data {
        guard let profilePicture = profilePicture else {
            throw ValidationError.profilePicture
        }
        return profilePicture
    }
    static func validate(licensePicture: Data?) throws -> Data {
        guard let licensePicture = licensePicture else {
            throw ValidationError.licensePicture
        }
        return licensePicture
    }
    static func validate(productPicture: Data?) throws -> Data {
        guard let productPicture = productPicture else {
            throw ValidationError.productPicture
        }
        return productPicture
    }
    
    //MARK: - Cars -
    static func validate(carPicture: Data?) throws -> Data {
        guard let carPicture = carPicture else {
            throw ValidationError.carPicture
        }
        return carPicture
    }
    static func validate(carPlate: String?) throws -> String {
        guard let carPlate = carPlate, !carPlate.trimWhiteSpace().isEmpty else {
            throw ValidationError.carPlate
        }
        return carPlate
    }
    static func validate(carModel: Int?) throws -> Int {
        guard let carModel = carModel else {
            throw ValidationError.carModel
        }
        return carModel
    }
    static func validate(carType: Int?) throws -> Int {
        guard let carType = carType else {
            throw ValidationError.carType
        }
        return carType
    }
    
    //MARK: - Date -
    static func validate(age: String?) throws -> String {
        guard let age = age, !age.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyAge
        }
        guard age.toInt() > 0 else {
            throw ValidationError.youngAge
        }
        return age
    }
    static func validate(oldDate: String?) throws -> String {
        guard let oldDate = oldDate, let date = oldDate.toDate() else {
            throw ValidationError.emptyDate
        }
        guard date.isBeforeNow() else {
            throw ValidationError.notOldDate
        }
        return oldDate
    }
    static func validate(newDate: String?) throws -> String {
        guard let newDate = newDate, let date = newDate.toDate() else {
            throw ValidationError.emptyDate
        }
        guard date.isBeforeNow() else {
            throw ValidationError.notNewDate
        }
        return newDate
    }
    static func validate(date: String?) throws -> String {
        guard let date = date, !date.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyDate
        }
        return date
    }
    
    static func validate(time: String?) throws -> String {
        guard let time = time, !time.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyTime
        }
        return time
    }
    
    //MARK: - Message -
    static func validate(title: String?) throws -> String {
        guard let title = title, !title.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyTitle
        }
        return title
    }
    static func validate(titleType: String?) throws -> String {
        guard let titleType = titleType, !titleType.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyTitleType
        }
        return titleType
    }
    
    static func validate(message: String?) throws -> String {
        guard let message = message, !message.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyMessage
        }
        return message
    }
    
    //MARK: - Bank -
    static func validate(bankAccountHolder: String?) throws -> String {
        guard let bankAccountHolder = bankAccountHolder, !bankAccountHolder.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankAccountHolder
        }
        return bankAccountHolder
    }
    static func validate(bankName: String?) throws -> String {
        guard let bankName = bankName, !bankName.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankName
        }
        return bankName
    }
    static func validate(fromBankName: String?) throws -> String {
        guard let fromBankName = fromBankName, !fromBankName.trimWhiteSpace().isEmpty else {
            throw ValidationError.fromBankName
        }
        return fromBankName
    }
    static func validate(bankAccountNumber: String?) throws -> String {
        guard let bankAccountNumber = bankAccountNumber, !bankAccountNumber.trimWhiteSpace().isEmpty else {
            throw ValidationError.bankAccountNumber
        }
        return bankAccountNumber
    }
    static func validate(bankTransferImage: Data?) throws -> Data {
        guard let bankTransferImage = bankTransferImage else {
            throw ValidationError.bankTransferImage
        }
        return bankTransferImage
    }
    
    //MARK: - Categories -
    static func validate(categoryId: Int?) throws -> Int {
        guard let categoryId = categoryId else {
            throw ValidationError.emptyCategory
        }
        return categoryId
    }
    static func validate(priceBefore: String?, priceAfter: String?) throws -> (priceBefore: String, priceAfter: String) {
        guard let priceBefore = priceBefore, !priceBefore.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPriceBefore
        }
        guard let priceAfter = priceAfter, !priceAfter.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyPriceAfter
        }
        guard priceBefore.toDouble() > priceAfter.toDouble() else {
            throw ValidationError.priceBeforeSmallThanPriceAfter
        }
        return (priceBefore, priceAfter)
        
    }
    static func validate(description: String?) throws -> String {
        guard let description = description, !description.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyDescription
        }
        return description
    }
    
    
    //MARK: - Employee
    
    static func validate(employeeId: Int?) throws -> Int {
        guard let employeeId = employeeId else {
            throw ValidationError.emptyEmployee
        }
        return employeeId
    }
    
    
    //MARK: - PaymentId
    
    static func validate(paymentId: Int?) throws -> Int {
        guard let paymentId = paymentId else {
            throw ValidationError.emptyPaymentMethod
        }
        return paymentId
    }
    
    static func validate(paymentMethods: String?) throws -> String {
        guard let paymentMethods = paymentMethods else {
            throw ValidationError.emptyPaymentMethod
        }
        return paymentMethods
    }
    
    
    //MARK: - cancel reason
    static func validate(cancelReason: String?) throws -> String {
        guard let cancelReason = cancelReason, !cancelReason.trimWhiteSpace().isEmpty else {
            throw ValidationError.cancelReason
        }
        return cancelReason
    }
    
    //MARK: - Rating

    static func validate(rate: Float?) throws -> Float {
        guard let rate = rate, rate != 0.0 else {
            throw ValidationError.emptyRating
        }
        return rate
    }
    
    static func validate(comment: String?) throws -> String {
        guard let string = comment, !string.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyComment
        }
        return string
    }
    
    
    //MARK: - Provider Type -

    static func validate(providerType: String?) throws -> String {
        guard let providerType = providerType, !providerType.trimWhiteSpace().isEmpty else {
            throw ValidationError.emptyProviderType
        }
        return providerType
    }
    
    
    //MARK: - Service ID -

    static func validate(serviceId: Int?, serviceTitle: String) throws -> Int {
        guard let serviceId = serviceId else {
            throw ValidationError.emptyService(serviceTitle: serviceTitle)
        }
        return serviceId
    }
    
   
    
    //MARK: - Order Notes -

    static func validate(notes: String?) throws -> String {
        guard let notes = notes,  !notes.trimWhiteSpace().isEmpty  else {
            throw ValidationError.emptyOrderNotes
        }
//        
//        guard !notes.isValidPhoneNumber(pattern: RegularExpression.saudiArabiaPhone.value) else {
//            throw ValidationError.shouldNotContainPhoneNumber
//        }
        return notes
    }
    
    
    
    static func validate(uploadData: [Data]) throws -> [Data] {
            guard !uploadData.isEmpty else {
                throw ValidationError.emptyOrderImages
            }
            return uploadData
        }
    
}

