//
//  WishListHomeViewController.swift
//  Yaari
//
//  Created by Mac on 24/09/21.
//

import UIKit

class WishListHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let array = ["Wishlist","Shared"]
    var fromSharedCatalogue = false
    @IBOutlet weak var heightConstraintStack: NSLayoutConstraint!
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
        if fromSharedCatalogue {
            stackViewTop.isHidden  = true
            heightConstraintStack.constant = 0
        }
        else {
            stackViewTop.isHidden  = false
            heightConstraintStack.constant = 48
        }
      //  setupYSLMenuViewController()
    }
    
    
    func setupNavigationBar() {

        self.tabBarController?.tabBar.isHidden = true

        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        
        let btnFavorite = UIButton.init(type: .custom)
        btnFavorite.setImage(UIImage(named: "favorites"), for: .normal)
           // btnSearch.addTarget(self, action: #selector(MyPageContainerViewController.searchButtonPressed), for: .touchUpInside)

        let btnNotification = UIButton.init(type: .custom)
        btnNotification.setImage(UIImage(named: "notifications"), for: .normal)
            //btnEdit.addTarget(self, action: #selector(MyPageContainerViewController.editButtonPressed), for: .touchUpInside)
        
        let btnCart = UIButton.init(type: .custom)
        btnCart.setImage(UIImage(named: "cart"), for: .normal)
        btnCart.addTarget(self, action: #selector(HomeViewController.cartButtonPressed), for: .touchUpInside)

        let stackview = UIStackView.init(arrangedSubviews: [btnFavorite,btnNotification,btnCart])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10

        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
         self.title = "Wishlist"

    }
    @objc func backBtnAction() {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListCell", for: indexPath) as! WishListTableViewCell
        cell.btnViewDetails.tag = indexPath.row
        cell.btnViewDetails.addTarget(self, action: #selector(self.btnViewDetailAction), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    @objc func btnViewDetailAction(sender: UIButton) {
        tableView.beginUpdates()
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let tableViewCell = self.tableView.cellForRow(at: indexPath) as! WishListTableViewCell
        if tableViewCell.viewDetails.isHidden {
            tableViewCell.viewDetails.isHidden = false
            tableViewCell.heightConstraintDetails.constant = 217
            tableViewCell.btnViewDetails.setTitle("Close", for: .normal)
        }
        else {
        tableViewCell.viewDetails.isHidden =  true
        tableViewCell.heightConstraintDetails.constant = 0
        tableViewCell.btnViewDetails.setTitle("View Details", for: .normal)

        }
        tableView.endUpdates()
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
