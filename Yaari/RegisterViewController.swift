//
//  RegisterViewController.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import UIKit
import Alamofire
import KRProgressHUD

class RegisterViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    var message = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldFirstName.setLeftPaddingPoints(10)
        textFieldLastName.setLeftPaddingPoints(10)
        textFieldEmail.setLeftPaddingPoints(10)
        disableBtn()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let getMobile = UserDefaults.standard.string(forKey: AppURL.setMobile)!
        
        getRegister(Mobile:getMobile,firstName: textFieldFirstName.text!, lastName: textFieldLastName.text!, email: textFieldEmail.text!)
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textFieldFirstName.text!.isEmpty && !textFieldLastName.text!.isEmpty && !textFieldEmail.text!.isEmpty {
            enableBtn()
        }
        else {
            disableBtn()
        }
    }
    func enableBtn() {
        btnNext.isEnabled = true
        btnNext.backgroundColor  = Colors.enabledColor
        
        
    }
    func disableBtn() {
        btnNext.isEnabled = false
        btnNext.backgroundColor  = Colors.disabledColor
    }
    /// Normal User Register Api
    /// - Parameter mobile
    /// - Parameter firstName
    /// - Parameter lastName
    /// - Parameter email
    
    
    
    ///   Method Param
    /// - Parameter Mobile Number & referralcode
    func getRegister(Mobile: String,firstName:String,lastName:String,email:String) {
        KRProgressHUD.show()
        let parametersBal: Parameters = [
            AppURL.mobile: Mobile,
            AppURL.firstName:firstName,
            AppURL.lastName:lastName,
            AppURL.email:email
        ]
        
        print(parametersBal)
        
        Alamofire.request(AppURL.usersRegister, method: .post, parameters: parametersBal).responseJSON { [self]
            response in
            print(response)
            if response.result.isSuccess {
                if let result = response.result.value {
                    
                    let statusCode = response.response!.statusCode
                    KRProgressHUD.dismiss()
                    print(statusCode)
                    
                    if statusCode == 201 {
                        
                        showDashboard()
                        
                    } else {
                        self.message = (result as AnyObject).value(forKey: AppURL.message) as! String
                        
                        
                        
                        AlertManager.ShowAlertWithOk(title: AppURL.Register, message: self.message,presentedViewController: self)
                        
                    }
                }
            }
        }
    }
    
}
