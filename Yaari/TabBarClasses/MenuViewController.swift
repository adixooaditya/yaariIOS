//
//  MenuViewController.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let menuItems  = ["Profile","My Orders","My Subscriptions","Address Book","Share With Friends","Connected Accounts","Change Password","Help Center","Notifications","Logout","About","Rate Us On AppStore"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.font = UIFont.init(name: "Poppins-Regular", size: 15.0)
        cell.textLabel?.textColor = UIColor.lightGray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            let view = self.storyboard?.instantiateViewController(withIdentifier: "AddressBookViewController") as! AddressBookViewController
            self.navigationController?.pushViewController(view, animated: true)
        case 9:
            Logout()
        default:
            print("default")
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
