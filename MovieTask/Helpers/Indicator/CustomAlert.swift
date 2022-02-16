//
//  CustomAlert.swift
//  WawProvider
//
//  Created by Mohamed Aglan on 10/18/21.
//

import UIKit

//MARK:- Enums
enum AlertType {
    case warning
    case success
    case error
    case addedToFav
    case addedToCart
    case deletedFromCart
    
    var image: String {
        switch self {
        case .warning:
            return "warningAlert"
        case .success:
            return "successAlert"
        case .error:
            return "errorAlert"
        case .addedToFav:
            return "addedToFav"
        case .addedToCart:
            return "addedToCart"
        case .deletedFromCart:
            return "deletedFromCart"
        }
    }
}



class CustomAlert: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    //MARK:- Properities -
    
    var message: String?
    var type: AlertType?
    
    //MARK:- Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 12
        self.setupDesign()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showAnimate()
    }
    
    //MARK:- Design Methods -
    func setupDesign() {
        self.alertLabel.text = self.message
        if let type = self.type {
            self.imageView.image = UIImage(named: type.image)
        }
//        self.showAnimate()
        self.alertView.transform = CGAffineTransform(translationX: 0, y: -self.alertView.bounds.height * 2)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    func showAnimate(){
        self.alertView.transform = CGAffineTransform(translationX: 0, y: -self.alertView.bounds.height * 2)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.alertView.transform = .identity
        } completion: { [weak self] _ in
            guard let self = self else {return}
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.removeAnimate()
            }
        }
    }
    func removeAnimate(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alertView.transform = CGAffineTransform(translationX: 0, y: -self.alertView.bounds.height * 2)
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
}
