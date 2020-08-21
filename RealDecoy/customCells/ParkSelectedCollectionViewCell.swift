//
//  ParkSelectedCollectionViewCell.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit

class ParkSelectedCollectionViewCell: UICollectionViewCell {

    @IBOutlet  weak var containerView: UIView!
     @IBOutlet  weak var imageView: UIImageView!
     @IBOutlet  weak var parkdescription: UILabel!
     @IBOutlet  weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpConstraints()
        // Initialization code
    }
    var photo: Photo? {
       didSet {
         if let photo = photo {
           imageView.image = photo.image
           parkdescription.text = photo.caption
           
         }
       }
     }
    
    func setUpConstraints(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        parkdescription.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.black
        parkdescription.textColor = UIColor.white
        name.textColor = UIColor.white
        contentView.layer.cornerRadius = 20
        
        name.sizeToFit()
        name.numberOfLines = 0
        name.textAlignment = .left
        name.font.withSize(9)
        
        parkdescription.sizeToFit()
        parkdescription.numberOfLines = 0
        parkdescription.textAlignment = .left
        parkdescription.font.withSize(9)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: containerView.frame.height * 0.5),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            name.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            name.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            parkdescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0),
            parkdescription.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            parkdescription.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            parkdescription.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])
    }

}
