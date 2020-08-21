//
//  ParksMapViewController.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit
import DrawerView
class ParksMapViewController: UIViewController {
    let drawerView = DrawerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        drawerView.attachTo(view: self.view)
        drawerView.snapPositions = [.collapsed, .partiallyOpen]

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
