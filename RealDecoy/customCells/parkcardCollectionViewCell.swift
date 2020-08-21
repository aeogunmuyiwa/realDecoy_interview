//
//  parkcardCollectionViewCell.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit

class parkcardCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configuration()
        // Initialization code
    }
    func configuration(){
        location.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor.black
        location.textColor = UIColor.white
        
        NSLayoutConstraint.activate([
         
            
            location.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            location.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
           // location.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
    }

}
