//
//  HelpViewController.swift
//  Yaari
//
//  Created by Mac on 18/10/21.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Help"

        // Do any additional setup after loading the view.
        
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        
        self.navigationItem.leftBarButtonItem  = button1
    }
    @objc func backBtnAction() {
        self.tabBarController?.tabBar.isHidden = false

        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnPhoneNumberAction(_ sender: Any) {
        let phoneNumber = "+91-91520 00300"
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    if #available(iOS 10.0, *) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                         application.openURL(phoneCallURL as URL)

                    }
                }
            }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
