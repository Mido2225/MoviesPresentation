//
//  BaseClass.swift
//  Mahfol
//
//  Created by Mohamed Aglan on 11/3/21.
//

import UIKit

protocol BaseProtocol: AnyObject {
    func showIndicator()
    func hideIndicator()
    func showErrorAlert(error: String?)
    func showSuccessAlert(message: String?)
    func showWarningAlert(warning:String?)

}

class BaseVC: UIViewController {
    var loadView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    deinit {
        print("\(NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? "BaseVC") is deinit, No memory leak found")
    }
    
    func alertMessage(message:String ,type:AlertType = .error) {
            let vc = CustomAlert()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.message = message
            vc.type = type
            self.present(vc, animated: true)
        }
    

    
    
}
    
extension BaseVC : BaseProtocol{
    
    func showIndicator(){
        loadView = UIView(frame: UIScreen.main.bounds)
        view.addSubview(loadView)

        loadView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1281390547)
        
        UIView.animate(withDuration: 0.15) {
            self.loadView.alpha = 0.95
        }
        
        let cornerView = UIView()
        cornerView.translatesAutoresizingMaskIntoConstraints = false
        cornerView.layer.cornerRadius = 12
        cornerView.backgroundColor = UIColor(named: "BlueBase")
        loadView.addSubview(cornerView)
        
        NSLayoutConstraint.activate([
            cornerView.widthAnchor.constraint(equalToConstant: 85),
            cornerView.heightAnchor.constraint(equalToConstant: 85),
            cornerView.centerYAnchor.constraint(equalTo: loadView.centerYAnchor),
            cornerView.centerXAnchor.constraint(equalTo: loadView.centerXAnchor)
            ])
        
        let activivtyIndicator = UIActivityIndicatorView(style: .large)
        activivtyIndicator.color = .black
        loadView.addSubview(activivtyIndicator)
        
        activivtyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activivtyIndicator.centerYAnchor.constraint(equalTo: cornerView.centerYAnchor),
            activivtyIndicator.centerXAnchor.constraint(equalTo: cornerView.centerXAnchor)
        ])
        activivtyIndicator.startAnimating()
    }
    func hideIndicator(){
        DispatchQueue.main.async {
            if self.loadView != nil {
                self.loadView.removeFromSuperview()
                self.loadView = nil
            }
        }
        
    }
    
    func showErrorAlert(error: String?){
        self.alertMessage(message: error ?? "Error", type: .error)
    }
    func showSuccessAlert(message: String?){
        self.alertMessage(message: message ?? "Success", type: .success)
    }
    
    func showWarningAlert(warning:String?) {
        self.alertMessage(message: warning ?? "Warning", type: .warning)
    }
   
}

extension BaseVC : UIGestureRecognizerDelegate{}





