//
//  AddNewAddressViewController.swift
//  Yaari
//
//  Created by Mac on 01/09/21.
//

import UIKit
import BottomPopup

class AddNewAddressViewController: UIViewController, BottomPopupDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Delivery Address"
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        // Do any additional setup after loading the view.
    }
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnSelectStateAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SelectStateCityViewController") as? SelectStateCityViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        popupVC.fromState = true
        present(popupVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSelectCityAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SelectStateCityViewController") as? SelectStateCityViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        popupVC.fromState = false
        present(popupVC, animated: true, completion: nil)
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
