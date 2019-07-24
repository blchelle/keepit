//
//  AddHotSpotViewController.swift
//  ItemTracker
//
//  Created by Brock Chelle on 2019-07-24.
//  Copyright © 2019 Brock Chelle. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AddGeoFenceProtocol {
    
    func geoFenceAdded(geofence: GeoFence)
    
}

class AddHotSpotViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    @IBOutlet var dimView: UIView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var floatingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var floatingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var floatingViewY: NSLayoutConstraint!
    
    @IBOutlet weak var hotSpotNameTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mapSearchBar: RoundedSearchBar!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addHotSpotButton: RoundedButton!
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var delegate: AddGeoFenceProtocol?
    
    var name: String?
    var center: [Double]?
    var radius: Double = 200
    var triggerOnEntrance: Bool = true
    var triggerOnExit: Bool = false
    
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the dimView
        dimView.backgroundColor        = UIColor.clear
        
        // Set up the back button
        backButton.tintColor           = Constants.Color.primary
        
        // Setup the floatingView
        floatingViewWidth.constant     = Constants.View.Width.standard
        floatingViewHeight.constant    = Constants.View.Height.addHotSpot
        floatingViewY.constant         = UIScreen.main.bounds.height
        
        // Setup the text field
        hotSpotNameTextField.delegate  = self
        hotSpotNameTextField.tintColor = Constants.Color.primary
        
        // Set up the segmented control
        segmentedControl.tintColor     = Constants.Color.primary
        
        // Setup the Map View
        mapView.delegate               = self
        mapView.showsUserLocation      = true
        mapView.layer.borderWidth      = 1
        mapView.layer.borderColor      = Constants.Color.primary.cgColor
        mapView.tintColor              = Constants.Color.primary
        mapView.showsUserLocation      = false
        
        // Setup the Map Search Bar
        mapSearchBar.delegate          = self
        mapSearchBar.layer.borderWidth = 1
        mapSearchBar.layer.borderColor = Constants.Color.primary.cgColor
        mapSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        // Setup the radius text field
        radiusTextField.delegate       = self
        radiusTextField.tintColor      = Constants.Color.primary
        
        // Set up the add hot spot button
        addHotSpotButton.activateButton(isActivated: false , color: Constants.Color.inactiveButton)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: false)
        radiusTextField.inputAccessoryView = toolBar
        
        // Check Location Services
        setupLocationManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Slide the view in
        slideViewIn()
    }
    
}

// MARK: - Navigation Bar Methods
extension AddHotSpotViewController {
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        
        // Slide the view out
        slideViewOut()
        
    }
    
}

// MARK: - Text Field Methods
extension AddHotSpotViewController: UITextFieldDelegate {
    
    @IBAction func hotSpotNameTextFieldEditing(_ sender: Any) {
        
        // Get the name from the text field
        name = hotSpotNameTextField.text?.trimmingCharacters(in: .whitespaces)
        
        // Check to see if the button should be activated
        checkToActivateButton()
        
    }
    
    @IBAction func radiusTextFieldDoneEditing(_ sender: UITextField) {
        
        drawGeoFence(center: mapView.overlays[0].coordinate)
        
    }
    
    @objc func doneButtonTapped() {
        
        view.endEditing(true)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard textField == radiusTextField else { return true }
        
        // Find out what the text field will be after adding the current edit
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if let numText = Double(text) {
            radius = numText
        }
        
        // Return true so the text field will be changed
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Lower the keyboard
        textField.resignFirstResponder()
        return true
        
    }
    
}

// MARK: - Segmented Control Methods
extension AddHotSpotViewController {
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            triggerOnEntrance = true
            triggerOnExit = false
        case 1:
            triggerOnEntrance = false
            triggerOnExit = true
        case 2:
            triggerOnEntrance = true
            triggerOnExit = true
        default:
            triggerOnEntrance = false
            triggerOnExit = false
        }
        
    }
    
}

// MARK: - Map Methods
extension AddHotSpotViewController: MKMapViewDelegate {
    
    @IBAction func mapViewHeld(_ sender: UILongPressGestureRecognizer) {
        
        // Lower the keyboard
        lowerKeyboard()
        
        // Get the location of the touch in the mapView and convert it to a coordinate
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        center = [coordinate.latitude, coordinate.longitude]
        
        // Add the annotation to the map
        drawGeoFence(center: coordinate)
        
        // Check to see if the button should be activated
        checkToActivateButton()
        
    }
    
    func drawGeoFence(center: CLLocationCoordinate2D) {
        
        let circle = MKCircle(center: center, radius: radius as CLLocationDistance)
        mapView.removeOverlays(mapView.overlays)
        mapView.addOverlay(circle)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // Check if the overlay can be cast as an MKCircle
        guard let circleOverlay = overlay as? MKCircle else { return MKOverlayRenderer() }
        
        let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
        
        circleRenderer.strokeColor = Constants.Color.primary
        circleRenderer.lineWidth   = 5
        circleRenderer.fillColor   = Constants.Color.primary
        circleRenderer.alpha       = 0.5
        
        return circleRenderer
    }
    
    func centerMapOnUser(span: MKCoordinateSpan) {
        
        // Get the users location
        let location = locationManager.location?.coordinate
        guard location != nil else { return }
        
        // Get the center and the region
        let center = location!
        let region = MKCoordinateRegion.init(center: center, span: span)
        
        // Set the region
        mapView.setRegion(region, animated: true)
        
    }
    
}

// MARK: - Location Methods
extension AddHotSpotViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkLocationServices()
        
    }
    
    func setupLocationManager() {
        
        // Set the delegate for the location manager and give it high accuracy
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func checkLocationServices() {
        
        // If the user has location services enabled then setup the location manager and check authorization
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
        else {
            
            // Let the user know that they have to turn location services on
            slideViewOut()
            
        }
        
    }
    
    func checkLocationAuthorization() {
        
        // Determine the level of authorization the user has given you
        switch CLLocationManager.authorizationStatus() {
            
        // Case if its authorized
        case .authorizedAlways, .authorizedWhenInUse:
            centerMapOnUser(span: Constants.Map.defaultSpan)
            drawGeoFence(center: locationManager.location!.coordinate)
            
        // Case if its not determined
        case .notDetermined:
            break
            
        // Case if no authorization
        case .restricted, .denied:
            slideViewOut()
            
        @unknown default:
            break
        }
        
    }
    
}

// MARK: - Search Bar Methods
extension AddHotSpotViewController: UISearchBarDelegate {
    
}

// MARK: - Add Button Methods
extension AddHotSpotViewController {
    
    func checkToActivateButton() {
        
        // Check if all the info is filled
        guard name != nil, name!.count > 0, center != nil else {
            addHotSpotButton.activateButton(isActivated: false, color: Constants.Color.inactiveButton)
            return
        }
        
        addHotSpotButton.activateButton(isActivated: true, color: Constants.Color.primary)
        
    }
    
    @IBAction func addHotSpotButtonTapped(_ sender: RoundedButton) {
        
        let geoFence = GeoFence(name: name!,
                                centreCoordinate: center!,
                                radius: radius,
                                triggerOnEntrance: triggerOnEntrance,
                                triggerOnExit: triggerOnExit)
        
        LocalStorageService.createGeoFence(geoFence: geoFence)
        Stored.geoFences.append(geoFence)
        
        delegate?.geoFenceAdded(geofence: geoFence)
        
        slideViewOut()
        
    }
    
}

// MARK: - Animation Methods
extension AddHotSpotViewController {
    
    func slideViewIn() {
        
        // Slide the view in from the botton
        UIView.animate(withDuration: 0.2, animations: {
            
            // First, fade in the dimView
            self.dimView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 180/255)
            
        }) { (true) in
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                
                // Second, slide in the Floating View
                self.floatingViewY.constant = 0
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            
        }
        
    }
    
    func slideViewOut() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            
            // First, slide out the Floating View
            self.floatingViewY.constant = UIScreen.main.bounds.height
            self.view.layoutIfNeeded()
            
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                
                // Second, fade out the Dim View
                self.dimView.backgroundColor = UIColor.clear
                
            }, completion: { (true) in
                
                // Third, dismiss the VC
                self.dismiss(animated: false, completion: nil)
                
            })
        }
        
    }
    
    func lowerKeyboard() {
        
        hotSpotNameTextField.resignFirstResponder()
        mapSearchBar.resignFirstResponder()
        
    }
    
}

// MARK: - Helper Methods
extension AddHotSpotViewController {
    
}