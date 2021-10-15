//
//  NewMenuViewController.swift
//  Yaari
//
//  Created by Mac on 12/10/21.
//

import UIKit

class NewMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var arrayMenu = ["Bank Details","My Payments","My Shared Catalogues","Earn & Learn","Help","FAQ's"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yaari"
        // Do any additional setup after loading the view.
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        
        self.navigationItem.leftBarButtonItem  = button1
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func btnShowProfile(_ sender: Any) {
    }
    @objc func backBtnAction() {
        self.tabBarController?.tabBar.isHidden = false

        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnLogoutAction(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        let lblName = cell.contentView.viewWithTag(102) as! UILabel
        lblName.text = arrayMenu[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
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
