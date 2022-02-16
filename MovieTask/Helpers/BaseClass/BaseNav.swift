//
//  BaseNav.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import UIKit

class BaseNav: UINavigationController {
    //MARK:- Properities -
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
