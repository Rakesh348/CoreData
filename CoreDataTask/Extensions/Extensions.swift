//
//  Extensions.swift
//  CoreDataTask
//
//  Created by Rakesh on 17/12/21.
//

import UIKit


extension UITextField {
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}



extension UIViewController {
    
    //MARK:SHOW TOAST
    func showToast(message : String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    
        self.present(alert, animated: true)
        
        let duration: Double = 2
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}


