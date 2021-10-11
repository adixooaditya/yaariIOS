//
//  AlertManager.swift
//  GSTAccountsApp
//
//  Created by Mac on 04/06/21.
//

import Foundation
import UIKit

class AlertManager {
    static func ShowAlertWithOk(title : String, message : String ,presentedViewController: UIViewController) {
        // Alert Controller of Type Alert With Just Okay Action
        let alertPrompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: AlertMessages.Ok.rawValue, style: UIAlertAction.Style.cancel, handler: nil)
        alertPrompt.addAction(okayAction)
        presentedViewController.present(alertPrompt, animated: true, completion: nil)
    }
    static func ShowAlertWithTwoOptions(title : String, message : String , firstOption : String, secondOption : String, presentedViewController: UIViewController, handler: ((Bool) -> Void)? = nil) {
        let alertPrompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: firstOption, style: UIAlertAction.Style.default, handler:{ (action) -> Void in
           //if let vc = presentedViewController as? CompanyListViewController {
                
                // If ViewController Then Check Alert Type and Take Actions Accordingly
            handler!(true)
           // }
        })
        let secondAction = UIAlertAction(title: secondOption, style: UIAlertAction.Style.cancel, handler:{ (action) -> Void in
          // if let vc = presentedViewController as? CompanyListViewController {
                
                // If ViewController Then Check Alert Type and Take Actions Accordingly
            handler!(false)

           
           // }
        })
        alertPrompt.addAction(firstAction)
        alertPrompt.addAction(secondAction)
        presentedViewController.present(alertPrompt, animated: true, completion: nil)
        
    }
    static func ShowAlertWithOkHandler(title : String, message : String ,presentedViewController: UIViewController,handler: ((Bool) -> Void)? = nil) {
        // Alert Controller of Type Alert With Just Okay Action
        let alertPrompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: AlertMessages.Ok.rawValue, style: UIAlertAction.Style.cancel, handler:{ (action) -> Void in
    
     handler!(true)
    // }
 })
        alertPrompt.addAction(okayAction)
        presentedViewController.present(alertPrompt, animated: true, completion: nil)
    }
}
