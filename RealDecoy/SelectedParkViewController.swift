//
//  SelectedParkViewController.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit

class SelectedParkViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    //Mark : IBoutlet
    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var contactDetailView: UIView!
    @IBOutlet weak var parkFullname: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var hoursOfOperation: UILabel!
    @IBOutlet weak var hourseOfOperationDetail: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    private let mapViewDisplay = MKMapView(frame: .zero)
    private let locationManager = CLLocationManager()
    //Mark : Variables
    var index : Int?
    var selectedParkData : Activities?
    let Activitylayout = CustomLayout()
    let ActivityIdentifier = "activity"
    private let rangeInMeters: Double = 500
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewConfig() // mapview configurations
        Uiconfigurations()
        checkLocationServices()
        setupConstraints () // constriants configurations
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapViewConfig(){
        contentView.addSubview(mapViewDisplay)
        mapViewDisplay.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func Uiconfigurations(){
      
        navigationBar.title = datavalue.share.parkdetails?.data[index!].name
        
        locationUIConfig() //Uiconfigurations_ location label
        parkUIconfig() //Uiconfigurations_ parkfullname : textupdates etc for parkfullname label
        collectionViewConfig() //collection view configurations
        contactDetailViewUIConfig() //Uiconfigurations_ contactDetailView
        hourseOfOperationDetailUIConfig() //Uiconfigurations_ hourseOfOperationDetail
    }
    
    //Mark : Uiconfigurations_ location
    func locationUIConfig(){
        location.textColor = UIColor.black
        location.sizeToFit()
        let location_text = (datavalue.share.parkdetails?.data[index!].addresses.first!.line1 ?? "") + "," + (datavalue.share.parkdetails?.data[index!].addresses.first?.city ?? "")
        location.text = location_text
    }
    
    
    //Mark : Uiconfigurations_ parkfullname : textupdates etc for parkfullname label
    func parkUIconfig(){
        parkFullname.textColor = UIColor.black
        parkFullname.sizeToFit()
        parkFullname.numberOfLines = 1
        parkFullname.text = datavalue.share.parkdetails?.data[index!].fullName
    }
    
    //Mark : collection view configurations
    func collectionViewConfig(){
        //register custom xib file  for parkcollectionView
        let nib = UINib(nibName: "parkcardCollectionViewCell",bundle: nil)
        self.activitiesCollectionView.register(nib, forCellWithReuseIdentifier: ActivityIdentifier)
        activitiesCollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        activitiesCollectionView.dataSource = self
        activitiesCollectionView.backgroundColor  = #colorLiteral(red: 0.2941176471, green: 0.6156862745, blue: 0.6509803922, alpha: 1)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(detailViewCustomCell.self, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 260, height: 260)
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        //settings for activitiesCollectionView
        activityLabel.textColor = UIColor.white
        activitiesCollectionView.delegate = self
        let itemSize = (collectionView.frame.width - (activitiesCollectionView.contentInset.left + activitiesCollectionView.contentInset.right + 10)) / 2
        activitiesCollectionView.setCollectionViewLayout(Activitylayout, animated: true, completion: nil)
        
        activitiesCollectionView.allowsSelection = false
    }
    
    
    //Mark : Uiconfigurations_ contactDetailView
    func contactDetailViewUIConfig(){
        phoneNumber.textColor = UIColor.black
        phoneNumber.sizeToFit()
        phoneNumber.text = datavalue.share.parkdetails?.data[index!].contacts.phoneNumbers.first?.phoneNumber
        contactDetailView.layer.cornerRadius = 20
        contactDetailView.layer.allowsEdgeAntialiasing = true
        contactDetailView.layer.maskedCorners = .init(arrayLiteral: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner , .layerMinXMaxYCorner ,  .layerMinXMinYCorner])
        contactDetailView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6156862745, blue: 0.6509803922, alpha: 1)
        hourseOfOperationDetail.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6156862745, blue: 0.6509803922, alpha: 1)
        hoursOfOperation.textColor = UIColor.white
    }
    
    
    //Mark : Uiconfigurations_ hourseOfOperationDetail
    func hourseOfOperationDetailUIConfig(){
        if let hours = datavalue.share.parkdetails?.data[index!].operatingHours.first?.standardHours {
            hourseOfOperationDetail.text = "Monday: " + hours.monday + "\n" +  "Tuesday: " + hours.tuesday + "\n" + "Wednesday: " + hours.wednesday + "\n" + "Thursday: " + hours.thursday + "\n" + "Firday: " + hours.friday + "\n" + "Saturday: " + hours.saturday + "\n" + "Sunday: " + hours.sunday
        }else{
            hourseOfOperationDetail.isHidden = true
        }
    }
    
    
}





//mark collection view delegates
extension SelectedParkViewController{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         let count = datavalue.share.parkdetails?.data[index!].images.count
        //if collectionview is activitiesCollectionView use different numberOfItemsInSection
         if collectionView == activitiesCollectionView {
             if datavalue.share.parkdetails?.data[index!].activities.count == 0 {
                 collectionView.isHidden = true
             }
             return (datavalue.share.parkdetails?.data[index!].activities.count)!
             
         }
        //else collection view is detailViewCustomCell for images, use parkdetails?.data[index!].images.count
         return count!
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         if collectionView  == activitiesCollectionView {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityIdentifier, for: indexPath) as! parkcardCollectionViewCell
             if let activity = datavalue.share.parkdetails?.data[index!].activities[indexPath.row].name {
                 cell.state.text = activity
             }
             
             
             return cell
         }else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! detailViewCustomCell
             if let data = datavalue.share.parkdetails?.data[index!].images[indexPath.row].url {
                 let url = URL(string: data)
                 cell.imageView.kf.indicatorType = .activity
                 cell.imageView.kf.setImage(with: url)
             }
             return cell
         }
         
     }
}


//Mark : location manager delegates
extension SelectedParkViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationForLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    private func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            // Here we must tell user how to turn on location on device
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationForLocation()
    }
    
    
    
    
    
    private func checkAuthorizationForLocation() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                mapViewDisplay.showsUserLocation = true
                centerViewOnUser()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                // Here we must tell user how to turn on location on device
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Here we must tell user that the app is not authorize to use location services
                break
            @unknown default:
                break
        }
    }
    
    private func centerViewOnUser() {
        locationManager.location?.coordinate
        let parkLocation_lat_double = NSString(string: (datavalue.share.parkdetails?.data[index!].latitude)!).doubleValue
        let parkLocation_long_double = NSString(string: (datavalue.share.parkdetails?.data[index!].longitude)!).doubleValue
        let parkLocation_lat = CLLocationDegrees.init(exactly: parkLocation_lat_double)
        let parkLocation_long = CLLocationDegrees.init(exactly: parkLocation_long_double)
        //datavalue.share.parkdetails?.data[index!].latitude
        
        
        if let lat = parkLocation_lat {
            if let long = parkLocation_long {
                let parkLocation = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                
                
                let coordinateRegion = MKCoordinateRegion.init(center: parkLocation,
                                                               latitudinalMeters: rangeInMeters,
                                                               longitudinalMeters: rangeInMeters)
                mapViewDisplay.setRegion(coordinateRegion, animated: true)
                
                let point = MKPointAnnotation()
                point.title = datavalue.share.parkdetails?.data[index!].fullName
                point.coordinate = parkLocation
                self.mapViewDisplay.removeAnnotations(self.mapViewDisplay.annotations)
                self.mapViewDisplay.addAnnotation(point)
                
                let viewRegion = MKCoordinateRegion(center: parkLocation, latitudinalMeters: 500, longitudinalMeters: 500)
                self.mapViewDisplay.setRegion(viewRegion, animated: true)
                
                
                
                
                
            }
            
        }
        
    }
}

extension SelectedParkViewController {
    func setupConstraints(){
        parkFullname.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        hoursOfOperation.translatesAutoresizingMaskIntoConstraints = false
        hourseOfOperationDetail.translatesAutoresizingMaskIntoConstraints = false
        activitiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            
            contactDetailView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10),
            contactDetailView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            contactDetailView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            contactDetailView.heightAnchor.constraint(equalToConstant:  100),
            
            parkFullname.topAnchor.constraint(equalTo: contactDetailView.topAnchor , constant: 10),
            parkFullname.leftAnchor.constraint(equalTo: contactDetailView.leftAnchor, constant: 10),
            parkFullname.rightAnchor.constraint(equalTo: contactDetailView.rightAnchor, constant: -10),
            parkFullname.heightAnchor.constraint(equalToConstant:  30),
            
            location.topAnchor.constraint(equalTo: parkFullname.bottomAnchor, constant: 0),
            location.leftAnchor.constraint(equalTo: contactDetailView.leftAnchor, constant: 10),
            location.rightAnchor.constraint(equalTo: contactDetailView.rightAnchor, constant: -10),
            location.heightAnchor.constraint(equalToConstant:  30),
            
            phoneNumber.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 0),
            phoneNumber.leftAnchor.constraint(equalTo: contactDetailView.leftAnchor, constant: 10),
            phoneNumber.rightAnchor.constraint(equalTo: contactDetailView.rightAnchor, constant: -10),
            phoneNumber.heightAnchor.constraint(equalToConstant:  30),
            
            collectionView.topAnchor.constraint(equalTo: contactDetailView.bottomAnchor, constant: 30),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            mapViewDisplay.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            mapViewDisplay.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            mapViewDisplay.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            mapViewDisplay.heightAnchor.constraint(equalToConstant: 300),
            
            
            
            hoursOfOperation.topAnchor.constraint(equalTo: mapViewDisplay.bottomAnchor, constant: 5),
            hoursOfOperation.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            hoursOfOperation.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            hoursOfOperation.heightAnchor.constraint(equalToConstant: 30),
            
            hourseOfOperationDetail.topAnchor.constraint(equalTo: hoursOfOperation.bottomAnchor, constant: 0),
            hourseOfOperationDetail.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            hourseOfOperationDetail.widthAnchor.constraint(equalToConstant: contentView.frame.width ),
            hourseOfOperationDetail.heightAnchor.constraint(equalToConstant: 150),
            
            activityLabel.topAnchor.constraint(equalTo: hourseOfOperationDetail.bottomAnchor, constant: 0),
            activityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            activityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            activityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            activitiesCollectionView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 0),
            activitiesCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            activitiesCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            activitiesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
            
            
        ])
    }
}
