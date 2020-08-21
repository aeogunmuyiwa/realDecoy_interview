//
//  SelectedParkViewController.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    //Mark : Variables
    var index : Int?
    var selectedParkData : Activities?
    let Activitylayout = CustomLayout()
    let ActivityIdentifier = "activity"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configuration(){
        navigationBar.title = datavalue.share.parkdetails?.data[index!].name
        parkFullname.text = datavalue.share.parkdetails?.data[index!].fullName
        let location_text = (datavalue.share.parkdetails?.data[index!].addresses.first!.line1 ?? "") + "," + (datavalue.share.parkdetails?.data[index!].addresses.first?.city ?? "")
        location.text = location_text
        phoneNumber.text = datavalue.share.parkdetails?.data[index!].contacts.phoneNumbers.first?.phoneNumber
        
        parkFullname.textColor = UIColor.black
        location.textColor = UIColor.black
        phoneNumber.textColor = UIColor.black
        parkFullname.sizeToFit()
        parkFullname.numberOfLines = 1
        location.sizeToFit()
        phoneNumber.sizeToFit()
        parkFullname.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contactDetailView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        hoursOfOperation.translatesAutoresizingMaskIntoConstraints = false
        hourseOfOperationDetail.translatesAutoresizingMaskIntoConstraints = false
        activitiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        activitiesCollectionView.allowsSelection = false
         let itemSize = (collectionView.frame.width - (activitiesCollectionView.contentInset.left + activitiesCollectionView.contentInset.right + 10)) / 2
        activitiesCollectionView.setCollectionViewLayout(Activitylayout, animated: true, completion: nil)
        
        activitiesCollectionView.delegate = self
        hourseOfOperationDetail.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6156862745, blue: 0.6509803922, alpha: 1)
        
        contactDetailView.layer.cornerRadius = 20
        contactDetailView.layer.allowsEdgeAntialiasing = true
        contactDetailView.layer.maskedCorners = .init(arrayLiteral: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner , .layerMinXMaxYCorner ,  .layerMinXMinYCorner])
        contactDetailView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.6156862745, blue: 0.6509803922, alpha: 1)
        
        //register custom xib file  for parkcollectionView
        let nib = UINib(nibName: "parkcardCollectionViewCell",bundle: nil)
        self.activitiesCollectionView.register(nib, forCellWithReuseIdentifier: ActivityIdentifier)
        activitiesCollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        activitiesCollectionView.dataSource = self
        activitiesCollectionView.backgroundColor = UIColor.clear
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(detailViewCustomCell.self, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 260, height: 260)
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        if let hours = datavalue.share.parkdetails?.data[index!].operatingHours.first?.standardHours {
            hourseOfOperationDetail.text = "Monday: " + hours.monday + "\n" +  "Tuesday: " + hours.tuesday + "\n" + "Wednesday: " + hours.wednesday + "\n" + "Thursday: " + hours.thursday + "\n" + "Firday: " + hours.friday + "\n" + "Saturday: " + hours.saturday + "\n" + "Sunday: " + hours.sunday
        }else{
            hourseOfOperationDetail.isHidden = true
        }
        
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
            
            hoursOfOperation.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = datavalue.share.parkdetails?.data[index!].images.count
        if collectionView == activitiesCollectionView {
            return (datavalue.share.parkdetails?.data[index!].activities.count)!
        }
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView  == activitiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityIdentifier, for: indexPath) as! parkcardCollectionViewCell
            cell.location.text = datavalue.share.parkdetails?.data[index!].activities[indexPath.row].name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! detailViewCustomCell
            if let data = datavalue.share.parkdetails?.data[index!].images[indexPath.row].url {
                let url = URL(string: data)
                print(url)
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: url)
            }
            return cell
        }
        
    }
    
}

class detailViewCustomCell : UICollectionViewCell {
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints =  false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}