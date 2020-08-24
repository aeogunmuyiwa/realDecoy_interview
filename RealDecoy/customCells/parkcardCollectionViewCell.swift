//
//  parkcardCollectionViewCell.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit

class parkcardCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var state: UILabel!
    
    @IBOutlet weak var locationDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configuration()
        // Initialization code
    }
    func configuration(){
        state.translatesAutoresizingMaskIntoConstraints = false
        locationDetail.translatesAutoresizingMaskIntoConstraints = false
        locationDetail.sizeToFit()
        locationDetail.font = UIFont.systemFont(ofSize: 12)
        locationDetail.textColor = UIColor.white
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor.black
        state.textColor = UIColor.white
        state.sizeToFit()
        state.font = UIFont.systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
         
            
            state.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            state.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            
            locationDetail.topAnchor.constraint(equalTo: state.bottomAnchor, constant: 0),
              locationDetail.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
              locationDetail.heightAnchor.constraint(equalToConstant: 30)
            
           // location.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
    }

}
