//
//  TabBar.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/15/22.
//

import UIKit

class Tabs: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 1
    }
    
}

class AppTabBar: UITabBar {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.backgroundColor = UIColor.TabBarColor.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.5
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
     }
}

   

