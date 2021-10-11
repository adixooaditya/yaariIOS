//
//  AddressBookViewController.swift
//  Yaari
//
//  Created by Mac on 01/09/21.
//

import UIKit

class AddressBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Address Book"
        self.tabBarController?.tabBar.isHidden = true

        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        // Do any additional setup after loading the view.
    }
    
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    @IBAction func btnAddAddressAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddNewAddressViewController") as! AddNewAddressViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        return cell
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
