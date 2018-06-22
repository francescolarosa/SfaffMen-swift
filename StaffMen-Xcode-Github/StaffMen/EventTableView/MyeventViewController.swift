//
//  MyeventViewController.swift
//  StaffMen
//
//
//  Created by Andrex on 15/06/18
//  Copyright © 2018 Andrex. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
import MapKit
import CoreLocation
import SwiftyJSON
import GoogleMaps
import Foundation

class MyeventViewController: UIViewController,GMSMapViewDelegate,UITextFieldDelegate,GMSAutocompleteViewControllerDelegate,MKMapViewDelegate ,CLLocationManagerDelegate {

    var locationmanager : CLLocationManager!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var annotation: MKAnnotation!
    var selectedPin: MKPlacemark?
    @IBOutlet weak var view_mapContainer: GMSMapView!

    var diclatlong : NSMutableDictionary!
    @IBOutlet  var Scrollview: UIScrollView!
    @IBOutlet var txtserch : UITextField!
    @IBOutlet var txtmembertotal :UITextField!
    @IBOutlet var txtmembers_confirmed :UITextField!
    @IBOutlet var txtevent_date :UITextField!
    @IBOutlet var txttime_start :UITextField!
    @IBOutlet var txttime_end :UITextField!
    @IBOutlet var txtprize :UITextField!
    @IBOutlet var txttitle : UITextField!
    @IBOutlet var txtdescription : UITextView!
    

    let datePicker = UIDatePicker()
    let timepicker = UIDatePicker()
    @objc let tympicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     // locationmanager.delegate = self
      //  locationmanager.requestWhenInUseAuthorization()
       // locationmanager.startUpdatingLocation()
       // locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        
        //txt field shadow
        //To apply corner radius
        txtserch.layer.cornerRadius = txtserch.frame.size.height / 2
        
        //To apply Shadow
        //Text field map
        txtserch.layer.shadowOpacity = 1
        txtserch.layer.shadowRadius = 3.0
        txtserch.layer.shadowOffset = CGSize.zero // Use any CGSize
        txtserch.layer.shadowColor = UIColor.gray.cgColor
        //Text field descrizione
        txtdescription.layer.shadowOpacity = 1
        txtdescription.layer.shadowRadius = 3.0
        txtdescription.layer.shadowOffset = CGSize.zero // Use any CGSize
        txtdescription.layer.shadowColor = UIColor.gray.cgColor
        ////
        
        
        view_mapContainer.isMyLocationEnabled = true
        view_mapContainer.settings.myLocationButton = true
        
        Scrollview.isScrollEnabled = true
        Scrollview.layer.cornerRadius = 20
        //Scrollview.contentSize = CGSize(width: 375, height: 1200)
        Scrollview.contentSize = CGSize(width: Scrollview.contentSize.width, height: 1770)

        self.txtserch.delegate = self
        
        resultsViewController = GMSAutocompleteResultsViewController()
       // resultsViewController?.delegate = self as! GMSAutocompleteResultsViewControllerDelegate

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let subView = UIView(frame: CGRect(x: 0, y: 15.0, width: 80.0, height: 35.0))

        subView.addSubview((searchController?.searchBar)!)
       // objMAP.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        resultsViewController = GMSAutocompleteResultsViewController()
       // resultsViewController?.delegate = self as!
        
    
        datePicker.datePickerMode = UIDatePickerMode.date
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(MyeventViewController.dismissPicker))
        txtevent_date.inputAccessoryView = toolBar
        txtevent_date.inputView = datePicker
    
        datePicker.addTarget(self,action:#selector(datePickerChanged),
                             for:.valueChanged)
        
        datePicker.minimumDate = Date()

        timepicker.datePickerMode = UIDatePickerMode.time
        txttime_start.inputView = timepicker
        txttime_end.inputView = tympicker
        txttime_start.inputAccessoryView = toolBar
        txttime_end.inputAccessoryView = toolBar
        
        timepicker.addTarget(self,action:#selector(timepickerchanged),
                             for:.valueChanged)
        
        tympicker.datePickerMode = UIDatePickerMode.time

        tympicker.addTarget(self, action:#selector(tympickervaluechanged),
                            for:.valueChanged)
        
       // (self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
    }
    
    @IBAction func returnToEvent(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissViewController() {
        
        //self.navigationController?.popToRootViewController(animated: true)
        
        guard let vc = self.presentingViewController else { return }

        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        print("time picker cambiato per evento")
        
      //  let dateFormatter = DateFormatter()
//
//        dateFormatter.timeStyle = DateFormatter.Style.short
//
//        let strDate = dateFormatter.string(from: datePicker.date)
//
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "yyyy/MM/dd"

        
        // Apply date format
        let strDate = dateFormatter.string(from: datePicker.date)
        
          txtevent_date.text = strDate
        //datePicker.removeFromSuperview() // if you want to remove time picker

        
    }
    
    @objc func timepickerchanged(datePicker:UIDatePicker)  {
//        let dateFormatter: DateFormatter = DateFormatter()
//
//        // Set date format
//        dateFormatter.dateFormat = "HH:mm "
//
//        // Apply date format
//        let strtime = dateFormatter.string(from: datePicker.date)
//
//        txttime_start.text = strtime
//
//        timepicker.removeFromSuperview()
        
        let formatter = DateFormatter()

        formatter.dateFormat = "HH:mm"
        txttime_start.text = formatter.string(from: datePicker.date)
        //timepicker.removeFromSuperview()
    }
    @objc func tympickervaluechanged(datePicker:UIDatePicker)  {

        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        txttime_end.text = formatter.string(from: datePicker.date)
        //tympicker.removeFromSuperview()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtserch
        {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.present(acController, animated: true, completion: nil)
        }
    }
    
   
    @IBAction func btn_tap_submit(sender: UIButton) {
       
      
        if (txtevent_date.text != nil)
        {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let someDate = txtevent_date.text
        
        if dateFormatterGet.date(from: someDate!) != nil {
            
        } else {
            // invalid format
        
            
            let alert = UIAlertController(title: "Aia", message: "Formato data non valido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
    
         }
        }
            
            if (txttime_start.text != nil)
            {
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "HH:mm"
                let someDate = txttime_start.text
                
                if dateFormatterGet.date(from: someDate!) != nil {
                    
                } else {
                    // invalid format
                    
                    let alert = UIAlertController(title: "Mmm", message: "Orario di inizio non valido", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
           
            if (txttime_end.text != nil)
            {
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "HH:mm"
                let someDate = txttime_end.text
                
                if dateFormatterGet.date(from: someDate!) != nil {
                    
                } else {
                    // invalid format
                    
                    let alert = UIAlertController(title: "Mmm", message: "Orario di fine non valido", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
            if (txtmembertotal.text?.isEmpty)! || (txtmembers_confirmed.text?.isEmpty)! || (txttitle.text?.isEmpty)! || (txtdescription.text?.isEmpty)! || (txtprize.text?.isEmpty)!
            {
                let alert = UIAlertController(title: "Eilà", message: "Per favore inserisci tutti i dati", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
       
            self.getdata()
          
     }
    }
    
    @IBAction func btn_cancel(sender: UIButton) {
        
        self.cleartext()
    }
    
    func cleartext() {
        
        txtdescription.text = ""
        txttitle.text = ""
        txtprize.text = ""
        txttime_start.text = ""
        txtevent_date.text = ""
        txtserch.text = ""
        txtmembers_confirmed.text = ""
        txtmembertotal.text = ""
        txttime_end.text = ""
        
        
        
    }
    

    func getdata()
    {
        let parameters = [
            "user_id": (UserDefaults.standard.object(forKey: "userstatus") as? String)!,
            "job_id": "1",
            "members_total":txtmembertotal.text!,
            "members_confirmed":txtmembers_confirmed.text!,
            "local":txtserch.text!,
            "event_date":txtevent_date.text!,
            "time_start":txttime_start.text!,
            "time_end":txttime_end.text!,
            "cost":txtprize.text!,
            "status":"1",
            "title":txttitle.text!,
            "description":txtdescription.text!
            
        ]
        
        print(parameters)
        
        let url =  AppConfig.proxy_server + "/api/createevent"
        Alamofire.request(url, method:.post, parameters:parameters,encoding: JSONEncoding.default).responseString { response in
            switch response.result {
            case .success:
                print(response)
                
               // let json = response.result.value
//
//                if((response.result.value) != nil) {
//                    let swiftyJsonVar = JSON(response.result.value!)
//
//                    let strmsg = swiftyJsonVar ["msg"] as! String

               // let msg = (json as! NSDictionary).value(forKey: "msg") as! String
                let alert = UIAlertController(title: "Yeah!", message: "Evento pubblicato correttamente!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.dismissViewController()
                
                
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Aia", message: "Impossibile pubblicare evento", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
      }
    }
    
    func searchPlace(txt: String) {
        
        view_mapContainer.clear()
        
        let mng = CLGeocoder()
        mng.geocodeAddressString(txt) { (placemarks, error) in
            
            DispatchQueue.main.async {
                
                guard let places = placemarks, let location = places.first?.location else {
                    
                    return
                }
                
                self.view_mapContainer.camera = GMSCameraPosition(target: location.coordinate, zoom: 13, bearing: 0, viewingAngle: 0)
                
                let marker = GMSMarker()
                marker.appearAnimation = GMSMarkerAnimation(rawValue: 1)!
                marker.position = location.coordinate
                marker.title = txt
                marker.snippet = txt
                marker.map = self.view_mapContainer
                
            }
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
       
        print("Nome Luogo: \(place.name)")
        print("Indirizzo: \(String(describing: place.formattedAddress))")
        self.txtserch.text = place.name + "" + place.formattedAddress!
        
        print("Attributi Luogo: \(String(describing: place.attributions))")
        print("Coordinate luogo: \(place.coordinate)")
        //Google Maps marker
        self.view_mapContainer.camera = GMSCameraPosition(target: place.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.appearAnimation = GMSMarkerAnimation(rawValue: 1)!
        marker.position = place.coordinate
        marker.title = "Il tuo evento"
        //marker.snippet = txt
        marker.map = self.view_mapContainer
        ///
        self.dismiss(animated: true, completion: nil)
//        diclatlong.setValue(place.coordinate, forKey: "coordinate")
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Errore: ", error.localizedDescription)
        self.dismiss(animated: true, completion: nil)


    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
         print("Screen evento chiusa")
        self.dismiss(animated: true, completion: nil)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
////        if !isCurrentLocation {
////            return
////        }
////
////        isCurrentLocation = false
//
//        let location = locations.last
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//        self.objMAP.setRegion(region, animated: true)
//
//        if self.objMAP.annotations.count != 0 {
//            annotation = self.objMAP.annotations[0]
//            self.objMAP.removeAnnotation(annotation)
//        }
//
//        let pointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = location!.coordinate
//        pointAnnotation.title = "La tua posizione"
//        objMAP.addAnnotation(pointAnnotation)
//    }
//
//
//   func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool)
//   {
//    let location = CLLocationCoordinate2D(latitude: 45.465454, longitude: 9.186516)
//
//    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//
//    let region = MKCoordinateRegion(center: location, span: span)
//
//    self.objMAP.setRegion(region, animated: true)
//
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//    {
//        let annotation = MKPointAnnotation()
//
//       // annotation.coordinate = diclatlong.value(forKey: "coordinate") as! CLLocationCoordinate2D
//        annotation.title = "Il tuo evento"
//
//        let location1 = CLLocationCoordinate2D(
//            latitude: 45.465454,
//            longitude: 9.186516)
//
//
//        let span1 = MKCoordinateSpanMake(2 ,2)
//
//        let region1 = MKCoordinateRegion(center: location1, span: span1)
//        objMAP.setRegion(region1, animated: true)
//
//        objMAP.addAnnotation(annotation)
//
//        if annotation is MKPointAnnotation {
//            //return nil so map view draws "blue dot" for standard user location
//            return nil
//        }
//
//        let reuseId = "pin"
//        var pinView = objMAP.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        pinView?.pinTintColor = UIColor.orange
//        pinView?.canShowCallout = true
//        return pinView
//    }
    
    
    
        
        // Turn the network activity indicator on and off again.
        func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Chiudi", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
