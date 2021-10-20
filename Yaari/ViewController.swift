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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: AppURL.Main, bundle: nil)

          let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController

        
        self.present(vc, animated: true, completion: nil)

        
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

                        let storyBoard: UIStoryboard = UIStoryboard(name: AppURL.Main, bundle: nil)

                          let vc = self.storyboard?.instantiateViewController(identifier: "OTPViewController") as! OTPViewController
                        vc.From = AppURL.Signup

                        
                        self.present(vc, animated: true, completion: nil)

                        
                        
                        

                        

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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    func decode(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[1]) ?? [:]
    }
    
    func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    func decodeJWTPart(_ value: String) -> [String: Any]? {
      guard let bodyData = base64UrlDecode(value),
        let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
          return nil
      }

      return payload
    }


    
    func categoryfliterList(categoryId:String) -> String{
        

            let strvalue = "{\"where\": {\"and\":[{\"status\":\"active\"},{\"or\":[{\"categoryId\":\"\(categoryId)\")}]}}"

      return strvalue
        
    }

    
    func fliter(collectsionId:String) -> String{
        

            let strvalue = "{\"where\": {\"and\":[{\"status\":\"active\"},{\"or\":[{\"collectionId\":\"\(collectsionId)\"}]}}"

      return strvalue
        
    }
    

    func showDashboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
        
        mainTabBarController.selectedIndex = 0
        self.present(mainTabBarController, animated: true, completion: nil)

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
    
    

    
    func Logout() {
        let uiAlert = UIAlertController(title: "LogOut", message: "Are You Sure Want to Logout ?", preferredStyle: UIAlertController.Style.alert)
        present(uiAlert, animated: true, completion: nil)
        uiAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in DispatchQueue.main.async {
           UserDefaults.standard.removeObject(forKey: AppURL.token)
        }
        self.setLogOut()
        let storyBoard: UIStoryboard = UIStoryboard(name: AppURL.Main, bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextViewController, animated: false, completion: nil)
        }))
        uiAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { _ in
        }))
    }
    
    
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
