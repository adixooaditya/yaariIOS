//
//  CategoriesViewController.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import UIKit
import SideMenu

class CategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let imageArr   = ["Essentials","Women's Wear","Men's Wear","Kids' Wear","Home & Kitchen"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        // Do any additional setup after loading the view.
        setupNavigationBar()
    }
    func setupNavigationBar() {

        let button1 = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action:  #selector(btnMenuAction))
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

        let stackview = UIStackView.init(arrangedSubviews: [btnFavorite,btnNotification,btnCart])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10

        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        

    }
    @objc func btnMenuAction() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigation") as! SideMenuNavigationController
        var set = SideMenuSettings()
        set.presentationStyle = SideMenuPresentationStyle.menuSlideIn
        set.presentationStyle.presentingEndAlpha = 0.6
        set.menuWidth = 270
        set.statusBarEndAlpha = 0
        menu.settings = set
        present(menu, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let imageView = cell.viewWithTag(101) as! UIImageView
        let imageName = imageArr[indexPath.row]
        imageView.image = UIImage.init(named: imageName)
        
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
