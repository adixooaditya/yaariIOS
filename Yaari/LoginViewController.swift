//
//  LoginViewController.swift
//  Yaari
//
//  Created by Mac on 03/08/21.
//

import UIKit
import Alamofire
import KRProgressHUD

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    var message = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setkeybaordhight()
        mobileText.delegate = self
        mobileText.keyboardType = .decimalPad
        mobileText.addDoneButtonToKeyboard(myAction: #selector(mobileText.resignFirstResponder))

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
    
    @IBAction func btnNextAction(_ sender: Any) {
        getLogin(Mobile: mobileText.text!)
    }
    @IBAction func btnSignupAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SignupViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       return range.location < 10
   }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 10 {
            enableBtn()
        }
        else {
           disableBtn()
        }
    }
    /// Normal SignUp Api with Mobile Number
    /// - Parameter mobile
    ///   Method Param
    /// - Parameter Mobile Number & referralcode
    func getLogin(Mobile: String) {
        KRProgressHUD.show()
        let parametersBal: Parameters = [
            AppURL.mobile: Mobile
        ]

        print(parametersBal)

        Alamofire.request(AppURL.getlogin, method: .post, parameters: parametersBal).responseJSON { [self]
            response in
            print(response)
            if response.result.isSuccess {
                if let result = response.result.value {
                    self.message = (result as AnyObject).value(forKey: AppURL.message) as!
                        NSString as String

                    let statusCode = response.response!.statusCode
                    print(statusCode)

                    if statusCode == 200 {
                        KRProgressHUD.dismiss()
                        
                        
                        UserDefaults.standard.setValue(Mobile, forKey: AppURL.setMobile)
                        UserDefaults.standard.synchronize()


                          let vc = self.storyboard?.instantiateViewController(identifier: "OTPViewController") as! OTPViewController
                        vc.From = AppURL.Login

                         self.navigationController?.pushViewController(vc, animated: true)

                        

                    } else {
                        KRProgressHUD.dismiss()

                        AlertManager.ShowAlertWithOk(title: AppURL.Login, message: message,presentedViewController: self)
                        

                    }
                }
            }
        }
    }

}
