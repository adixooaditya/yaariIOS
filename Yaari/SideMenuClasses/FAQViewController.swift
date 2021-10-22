//
//  FAQViewController.swift
//  Yaari
//
//  Created by Mac on 18/10/21.
//

import UIKit

class FAQViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQ's"
        // Do any additional setup after loading the view.
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        
        self.navigationItem.leftBarButtonItem  = button1
    }
    @objc func backBtnAction() {
        self.tabBarController?.tabBar.isHidden = false

        navigationController?.popViewController(animated: true)
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
