//
//  LocationMapVC.swift
//  Artist
//
//  Created by AAIT on 10/09/2023.
//

import UIKit
import GooglePlaces
import GoogleMaps

enum ScreenType {
    case add
    case edit
}

protocol LocationMapDelegate: AnyObject {
    func locationWasPicked(location: Location, type: ScreenType)
}

class LocationMapVC: BaseVC {

    // MARK: - IBOutlets -
    
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var addessNameTextField: UITextField!
    @IBOutlet weak private var selectionView: UIView!
    
    // MARK: - Properties -
    private var mapView: GMSMapView!

    private var locator: Locator?

    private var marker = GMSMarker()
    
    private var mapLocation: CLLocationCoordinate2D?
    
    private  weak var delegate: LocationMapDelegate?
    
    private  var location: Location?
    
    private var type: ScreenType = .add

    
    
    
    // MARK: - Init -

    
    init(type: ScreenType, location: Location?, delegate: LocationMapDelegate) {
        
        self.type = type
        
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch self.type {
        case .add:
            self.title = "Add address".localized
            locator = Locator(delegate: self)
        case .edit:
            self.title = "Edit address".localized
            openOnLocaiton()
        }
    }
    
    // MARK: - IBActions -
    
    @IBAction private func confrimWasPressed(_ sender: UIButton) {
        confrimLocation()
    }
}


// MARK: - Helper Functions -
extension LocationMapVC {
    
    private func configuration() {
        setUpMapView()
        configureUI()
    }
    
    private func configureUI() {
        addessNameTextField.borderStyle = .none
    }
    
    
    private func setupConstraints() {
           mapView.translatesAutoresizingMaskIntoConstraints = false
           let leadingConstraint = mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
           let trailingConstraint = mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        let bottomConstraint = mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        let topConstraint = mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 0)
           NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, bottomConstraint,topConstraint])
       }
    
    
    private func setUpMapView() {
        let options = GMSMapViewOptions()
        mapView = .init(options: options)
        self.mapView.delegate = self
        locator = Locator(delegate: self)
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        self.mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 8)

        view.addSubview(mapView)
        view.addSubview(selectionView)
        setupConstraints()
    }
    
    private func confrimLocation() {
        guard let mapLocation = self.mapLocation else { return }
        self.pop {
            switch self.type {
            case .add:
                self.location = Location(id: nil,
                                         lat: mapLocation.latitude,
                                         lon: mapLocation.longitude,
                                         address: self.addressLabel.text ?? "",
                                         title: self.addessNameTextField.text,
                                         city: "",
                                         country: "")
            case .edit:
                self.location?.lat = mapLocation.latitude
                self.location?.lon = mapLocation.longitude
                self.location?.address = self.addressLabel.text ?? ""
                self.location?.title = self.addessNameTextField.text
            }
            
            guard let location = self.location else { return }
            
            self.delegate?.locationWasPicked(location: location, type: self.type)
        }
    }
}

// MARK: - LocatorDelegate -

extension LocationMapVC: LocatorDelegate {
    
    func updateUserLocation(lat: Double, long: Double) {
        let locaiton = CLLocationCoordinate2D(latitude: lat, longitude:  long)
        reversGecodeCoordinate(locaiton)
        let camera = GMSCameraPosition(latitude: locaiton.latitude, longitude: locaiton.longitude, zoom: 16.0)
        marker.position = locaiton
        marker.map = self.mapView
        marker.isDraggable = true
        marker.icon = #imageLiteral(resourceName: "marker")
        self.mapView.animate(to: camera)
    }
    
    func openOnLocaiton() {
        guard let location = self.location else { return self.pop() }
        self.addressLabel.text = location.address
        self.addessNameTextField.text = location.title
        let locaiton = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
        self.mapLocation = locaiton
        let camera = GMSCameraPosition(latitude: locaiton.latitude, longitude: locaiton.longitude, zoom: 16.0)
        marker.position = locaiton
        marker.map = self.mapView
        marker.isDraggable = true
        marker.icon = #imageLiteral(resourceName: "marker")
        self.mapView.animate(to: camera)
    }
    
    func showLocationAlert(message: String) {
        showErrorToast(with: message)
    }
    
    func showLocationEnable(message: String) {
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        let settingAction = UIAlertAction(title: "Settings".localized, style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        UIAlertController().showAlert(title: "Location Services Disable".localized, message: message, andAction: [settingAction, cancelAction], from: self)
    }
}


// MARK: - GMSMapViewDelegate -

extension LocationMapVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        reversGecodeCoordinate(coordinate)
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        guard let latitude = mapView.myLocation?.coordinate.latitude,
              let longitude = mapView.myLocation?.coordinate.longitude else { return false }
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 16.0)
        self.mapView.animate(to: camera)
        placeMarker(marker: marker, latitude: latitude, longitude: longitude)
        return true
    }
    
    func placeMarker(marker: GMSMarker, latitude: Double, longitude: Double) {
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.icon = #imageLiteral(resourceName: "marker")
        marker.map = self.mapView
        reversGecodeCoordinate(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
    
    func reversGecodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.mapLocation = coordinate
        AppHelper.getAddressFrom(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] address, city , country  in
            self?.addressLabel.text = address
            self?.location?.city = city ?? ""
            self?.location?.country = country ?? ""
            UIView.animate(withDuration: 0.4) {
                self?.view.layoutIfNeeded()
            }
        }
    }
}

struct Location: MarkrProtocal {
    var markerLat: Double {return lat}
    
    var markerLong: Double {return lon}
    
    var markerImage: String {return "location"}
    
    
    var id: Int?
    var lat: Double
    var lon: Double
    var address: String
    var city: String
    var country: String
    var title: String?
    
    
    init(id: Int? = nil, lat: Double, lon: Double, address: String, title: String? = nil, city: String , country: String) {
        self.id = id
        self.lat = lat
        self.lon = lon
        self.address = address
        self.title = title
        self.city = city
        self.country = country
    }
}
protocol MarkrProtocal: Codable {
    var markerLat: Double { get }
    var markerLong: Double { get }
    var markerImage: String { get }
}
