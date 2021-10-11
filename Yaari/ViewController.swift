//
//  ViewController.swift
//  Yaari
//
//  Created by Mac on 29/07/21.
//

import UIKit
import Alamofire
import KRProgressHUD


class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var btnNext: UIButton!

    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTerms: UILabel!
    var message = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    /// Initializing All the Objects
    func initialization() {
        hideKeyboardWhenTappedAround()
        setkeybaordhight()
        mobileText.delegate = self
        mobileText.keyboardType = .decimalPad
        mobileText.addDoneButtonToKeyboard(myAction: #selector(mobileText.resignFirstResponder))
        let termsString = "Terms & Conditions"
        let privacyString = "Privacy Policy"
        
        let underlineAttriString = NSMutableAttributedString(string: lblTerms.text!)
        
       let range1 = (lblTerms.text! as NSString).range(of:termsString)
       underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
       underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name:"Poppins-Regular",size:11) as Any, range: range1)
       underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range1)
        
        
        let range2 = (lblTerms.text! as NSString).range(of:privacyString)
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name:"Poppins-Regular",size:11) as Any, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range2)

        lblTerms.attributedText = underlineAttriString
        lblTerms.isUserInteractionEnabled = true
       // lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        disableBtn()
        //enableBtn()
    }

    func enableBtn() {
        btnNext.isEnabled = true
        btnNext.backgroundColor  = Colors.enabledColor
        
        
    }
    func disableBtn() {
        btnNext.isEnabled = false
        btnNext.backgroundColor  = Colors.disabledColor
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        navigationController?.popViewController(animated: true)
        
    }

    @IBAction func btnNextAction(_ sender: Any) {

        getSingup(Mobile: mobileText.text!)
        
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
    func getSingup(Mobile: String) {
        KRProgressHUD.show()
        let parametersBal: Parameters = [
            AppURL.mobile: Mobile
        ]

        print(parametersBal)

        Alamofire.request(AppURL.singupOtp, method: .post, parameters: parametersBal).responseJSON { [self]
            response in
            print(response)
            if response.result.isSuccess {
                if let result = response.result.value {
                    self.message = (result as AnyObject).value(forKey: AppURL.message) as!
                        NSString as String

                    let statusCode = response.response!.statusCode

                    if statusCode == 200 {
                        KRProgressHUD.dismiss()
                        
                        
                        UserDefaults.standard.setValue(Mobile, forKey: AppURL.setMobile)
                        UserDefaults.standard.synchronize()


                          let vc = self.storyboard?.instantiateViewController(identifier: "OTPViewController") as! OTPViewController
                        vc.From = AppURL.Signup

                         self.navigationController?.pushViewController(vc, animated: true)

                        

                    } else {
                        KRProgressHUD.dismiss()

                        AlertManager.ShowAlertWithOk(title: AppURL.Signup, message: message,presentedViewController: self)
                        
                        //"The Mobile Number Entered is Invalid"

                    }
                }
            }
        }
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func addDoneButtonToKeyboard(myAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: myAction)

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

}
extension UIViewController {
    
    
    

    func showDashboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }


    
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func applyShadowOnView(_ view: UIView) {
        view.layer.cornerRadius = 1
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 5
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    func setkeybaordhight(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);


        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
             self.view.frame.origin.y = -100 // Move view 150 points upward
        }
    
    @objc func keyboardWillHide(sender: NSNotification) {
             self.view.frame.origin.y = 0 // Move view to original position
        }

    
    func displayMyAlertMessage(title: String, userMessage: String) {
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - 75, y: view.frame.size.height - 100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    

    
//    func Logout() {
//        let uiAlert = UIAlertController(title: "LogOut", message: "Are You Sure Want to Logout ?", preferredStyle: UIAlertController.Style.alert)
//        present(uiAlert, animated: true, completion: nil)
//        uiAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in DispatchQueue.main.async {
//            UserDefaults.standard.removeObject(forKey: Constants.token)
//        }
//        self.setLogOut()
//        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Main, bundle: nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: Constants.IShopLoginVC) as! IShopLoginVC
//        self.present(nextViewController, animated: false, completion: nil)
//        }))
//        uiAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { _ in
//        }))
//    }
    
    
    func setLoggedIn() {
        UserDefaults.standard.setValue(AppURL.LoggedIn, forKey: AppURL.LoginStatus)
    }
    
    func setLogOut() {
        UserDefaults.standard.setValue(AppURL.LogOut, forKey: AppURL.LoginStatus)
    }
    
    func isLogin() -> String {
        return UserDefaults.standard.value(forKey: AppURL.LoginStatus) as! String
    }
}
