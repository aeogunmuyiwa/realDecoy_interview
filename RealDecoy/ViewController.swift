//
//  ViewController.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    

   
    
    let parkcollectionViewIdentifier = "parks"
    let layout = CustomLayout()
    
    
    var parkcollectionView : UICollectionView = {
        var collectionvIEW = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionvIEW.translatesAutoresizingMaskIntoConstraints = false
        collectionvIEW.allowsSelection = true

        collectionvIEW.showsVerticalScrollIndicator = true
        
        return collectionvIEW
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofiguration()
        setUpConstriants()
        // Do any additional setup after loading the view.
    }
    func cofiguration(){
        
        
        parkcollectionView.setCollectionViewLayout(layout, animated: true)
        if let layout = parkcollectionView.collectionViewLayout as? CustomLayout{
            parkcollectionView.delegate = self
        }
        view.addSubview(parkcollectionView)
        
        //register custom xib file  for parkcollectionView
        let nib = UINib(nibName: "parkcardCollectionViewCell",bundle: nil)
        self.parkcollectionView.register(nib, forCellWithReuseIdentifier: parkcollectionViewIdentifier)
        parkcollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        parkcollectionView.dataSource = self
        parkcollectionView.backgroundColor = UIColor.white
    }
    
    func setUpConstriants(){
        //view constriants setup
        
        NSLayoutConstraint.activate([
            
            
            parkcollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            parkcollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            parkcollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            parkcollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : selectedStateViewController = storyboard.instantiateViewController(withIdentifier: "selectedStateViewController") as! selectedStateViewController
        vc.state = Array(statecode)[indexPath.row].key
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
                   
        self.present(navigationController, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statecode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: parkcollectionViewIdentifier, for: indexPath) as! parkcardCollectionViewCell
        cell.state.text = Array(statecode)[indexPath.row].key
        cell.locationDetail.text = Array(statecode)[indexPath.row].value
        
        return cell
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
       return CGSize(width: itemSize, height: itemSize)
     }
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
//           <#code#>
//       }

}

