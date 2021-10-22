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
    var arrayImages = ["bank-building","myPayments","myCatalogue","learn","help","FAQ"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yaari"
        // Do any additional setup after loading the view.
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        
        self.navigationItem.leftBarButtonItem  = button1
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func btnShowProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(vc, animated: true)
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
        let iconImg = cell.contentView.viewWithTag(101) as! UIImageView
        iconImg.image = UIImage.init(named: arrayImages[indexPath.row])
        
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch arrayMenu[indexPath.row]{
        case "Help":
            let vc = storyboard?.instantiateViewController(identifier: "HelpViewController") as! HelpViewController
            navigationController?.pushViewController(vc, animated: true)
        case "Earn & Learn" :
            let vc = storyboard?.instantiateViewController(identifier: "EarnAndLearnViewController") as! EarnAndLearnViewController
            navigationController?.pushViewController(vc, animated: true)
        case "My Payments":
            let vc = storyboard?.instantiateViewController(identifier: "MyPaymentsViewController")  as! MyPaymentsViewController
            navigationController?.pushViewController(vc, animated: true)
        case "FAQ's":
            let vc = storyboard?.instantiateViewController(identifier: "FAQViewController")  as! FAQViewController
            navigationController?.pushViewController(vc, animated: true)
        case "Bank Details":
            let vc = storyboard?.instantiateViewController(identifier: "BankDetailsViewController")  as! BankDetailsViewController
            navigationController?.pushViewController(vc, animated: true)
        case "My Shared Catalogues":
            let vc = storyboard?.instantiateViewController(identifier: "WishListHomeViewController")  as! WishListHomeViewController
            vc.fromSharedCatalogue = true
            navigationController?.pushViewController(vc, animated: true)
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
