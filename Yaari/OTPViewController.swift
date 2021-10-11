//
//  OTPViewController.swift
//  Yaari
//
//  Created by Mac on 03/08/21.
//

import UIKit
import Alamofire
import KRProgressHUD

class OTPViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!

    @IBOutlet weak var mobilelbl: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    var message = String()
    var From = String()
    var getMobile = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
        textField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
        textField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
        textField4  .addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for:UIControl.Event.editingChanged)
        
        hideKeyboardWhenTappedAround()
        setkeybaordhight()
        textField1.delegate = self
        textField1.keyboardType = .decimalPad
        textField1.addDoneButtonToKeyboard(myAction: #selector(textField1.resignFirstResponder))
        
        textField2.delegate = self
        textField2.keyboardType = .decimalPad
        textField2.addDoneButtonToKeyboard(myAction: #selector(textField3.resignFirstResponder))
        
        textField3.delegate = self
        textField3.keyboardType = .decimalPad
        textField3.addDoneButtonToKeyboard(myAction: #selector(textField3.resignFirstResponder))


        textField4.delegate = self
        textField4.keyboardType = .decimalPad
        textField4.addDoneButtonToKeyboard(myAction: #selector(textField4.resignFirstResponder))

        
        if getMobile.isEmpty {
            getMobile = UserDefaults.standard.string(forKey: AppURL.setMobile)!
        }
        print(getMobile)

        mobilelbl.text = "Please type the verification code sent to +91" + getMobile
        disableBtn()
    }
    func enableBtn() {
        btnNext.isEnabled = true
        btnNext.backgroundColor  = Colors.enabledColor
        
        
    }
    func disableBtn() {
        btnNext.isEnabled = false
        btnNext.backgroundColor  = Colors.disabledColor
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString =
            currentString.replacingCharacters(in: range, with: string)
        print(currentString)
        print(newString)

        
        if newString.count > 1 {
            if (textField == self.textField1) {
                textField2.text = string
                textField2.becomeFirstResponder()
            }
            else if (textField == self.textField1) {
                textField3.text = string
                textField3.becomeFirstResponder()
            }
            else if (textField == self.textField3) {
                textField4.text = string
                textField4.becomeFirstResponder()
            }
            return false;
        }
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if text!.count == 1{
            if textField == textField1{
                textField2.becomeFirstResponder()
            }
            else if textField == textField2{
                textField3.becomeFirstResponder()
            }
            else if textField == textField3{
                textField4.becomeFirstResponder()
            }
            else {
                textField4.resignFirstResponder()
                enableBtn()
            }
        }
        else if text!.count == 0 {
            if textField == textField4{
                textField3.becomeFirstResponder()
            }
            else if textField == textField3{
                textField2.becomeFirstResponder()
            }
            else if textField == textField2{
                textField1.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        var OTP = String(textField1.text! + textField2.text! + textField3.text! + textField4.text!)
        
        if self.From == AppURL.Signup {

            matchOtpSingup(Mobile: getMobile, otp: OTP)
        }
        else if self.From == AppURL.Login {
            matchOtpLogin(Mobile: getMobile, otp: OTP)

        }
        
    }
    
    /// Match Otp task --- otp_verify
    /// - Parameter Mobile: Mobilel / otp
    /// - Mobile
    /// - otp

func matchOtpLogin(Mobile: String,otp: String) {
    KRProgressHUD.show()
    let parametersBal: Parameters = [
        AppURL.mobile: Mobile,
        AppURL.OTP: otp
    ]
    print(parametersBal)
    
    
    Alamofire.request(AppURL.matchOTPLogin, method: .post, parameters: parametersBal).responseJSON { [self]
        response in
        print(response)
        if response.result.isSuccess {
            if let result = response.result.value {
               // self.message = (result as AnyObject).value(forKey: AppURL.message) as!String
                let statusCode = response.response!.statusCode

                print(statusCode)
                if(statusCode == 200) {
                    KRProgressHUD.dismiss()
                    var token = String()
                    if let token1 = (result as AnyObject).value(forKey: AppURL.token) as? String{
                        token = token1
                    }else{
                        
                    }


                    UserDefaults.standard.setValue(token, forKey: AppURL.token)
                    UserDefaults.standard.synchronize()


                    
                       showDashboard()
                    
                        
                    
                }
                else {
                    self.message = (result as AnyObject).value(forKey: AppURL.message) as!
                        NSString as String

                    KRProgressHUD.dismiss()

                    AlertManager.ShowAlertWithOk(title: AppURL.otp, message: self.message,presentedViewController: self)
                }

            }
        }
    }
}

    

    
    /// Match Otp task --- otp_verify
    /// - Parameter Mobile: Mobilel / otp
    /// - Mobile
    /// - otp

func matchOtpSingup(Mobile: String,otp: String) {
    KRProgressHUD.show()
    let parametersBal: Parameters = [
        AppURL.mobile: Mobile,
        AppURL.OTP: otp
    ]
    print(parametersBal)
    
    
    Alamofire.request(AppURL.matchOTP, method: .post, parameters: parametersBal).responseJSON { [self]
        response in
        print(response)
        if response.result.isSuccess {
            if let result = response.result.value {
                self.message = (result as AnyObject).value(forKey: AppURL.message) as!String
                let statusCode = response.response!.statusCode

                print(statusCode)
                if(statusCode == 200) {
                    KRProgressHUD.dismiss()

                    let isValid1 = (result as AnyObject).value(forKey: "isValid") as AnyObject
                    let isValid = String(describing: isValid1)
                    

                        let vc = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
                        

                        self.navigationController?.pushViewController(vc, animated: true)


                    
                    
                        
                    
                }
                else {
                    KRProgressHUD.dismiss()

                    AlertManager.ShowAlertWithOk(title: AppURL.otp, message: self.message,presentedViewController: self)
                }

            }
        }
    }
}


}
