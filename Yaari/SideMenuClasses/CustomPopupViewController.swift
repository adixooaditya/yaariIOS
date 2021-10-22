//
//  CustomPopupViewController.swift
//  Yaari
//
//  Created by Mac on 22/10/21.
//

import UIKit

class CustomPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.20)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func btnYesAction(_ sender: Any) {
        let loginNavController = self.storyboard!.instantiateViewController(identifier: "LoginNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        
    }
}
