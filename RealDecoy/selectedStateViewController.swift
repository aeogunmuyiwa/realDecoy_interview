//
//  selectedStateViewController.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit
import Kingfisher

class selectedStateViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var activityView = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var navIteam: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var state : String!
    let layout = CustomLayout()
    var selectedParkData : Activities!
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.color = UIColor.gray
        self.activityView.startAnimating()
        configuration()
        setUpConstriants()
        self.navIteam.title = state
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        //initialze the service class, and make a request to the api for the selected statecode.
       let newRequest = ParkServices()
        newRequest.getRequestWithStateCode(statecode: state, oncompletion: {(result ) in
            
            self.selectedParkData = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityView.stopAnimating()
                
            }
            
        })
        self.collectionView.reloadData()
        
        
    }
    //controller setup
    func configuration(){
       
        collectionView.showsHorizontalScrollIndicator = true
        
        let nib = UINib(nibName: "ParkSelectedCollectionViewCell",bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "parks")
        collectionView.setCollectionViewLayout(layout, animated: true)
        if collectionView.collectionViewLayout is CustomLayout{
            collectionView.delegate = self
            
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    }
    
    func setUpConstriants(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
   
        print(navigationController!.navigationBar.frame.height)
        NSLayoutConstraint.activate([
        
            
            collectionView.topAnchor.constraint(equalTo:  view.layoutMarginsGuide.topAnchor, constant: 5),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
            
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
        
        return datavalue.share.parkdetails?.data.count ?? 0
      
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("dd")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : SelectedParkViewController = storyboard.instantiateViewController(withIdentifier: "SelectedParkViewController") as! SelectedParkViewController
        vc.index = indexPath.row
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parks", for: indexPath) as! ParkSelectedCollectionViewCell
        cell.photo?.caption = ""
        cell.name.text =  datavalue.share.parkdetails?.data[indexPath.row].name
        if let city = datavalue.share.parkdetails?.data[indexPath.row].addresses.first?.city {
            if let stateCode = datavalue.share.parkdetails?.data[indexPath.row].addresses.first?.stateCode {
                        cell.parkdescription.text = city + "," + stateCode
                   }
           
        }
       cell.imageView.kf.indicatorType = .activity
        
        if let data = datavalue.share.parkdetails?.data[indexPath.row].images.first?.url {
            let url = URL(string: data)
            cell.imageView.kf.setImage(with: url)
            
        }else{
            cell.imageView.image = UIImage(systemName: "icloud.fill")
        }
        cell.imageView.contentMode = .scaleAspectFill
        
    
        
        return cell
    }
    
    
}
