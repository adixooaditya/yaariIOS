//
//  CategoriesViewController.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import UIKit
import SideMenu
import Alamofire
import KRProgressHUD
import SDWebImage

class CategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let imageArr   = ["Essentials","Women's Wear","Men's Wear","Kids' Wear","Home & Kitchen"]
    
   // var imageArr = [String]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        // Do any additional setup after loading the view.
       // getBannerList()
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
//        let imageView = cell.viewWithTag(101) as! UIImageView
//
//        let getString = imageArr[indexPath.row]
//        let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)
//
//        imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)
//
//
//
//       // imageView.contentMode  = .scaleAspectFit
        
        let imageView = cell.viewWithTag(101) as! UIImageView
        let imageName = imageArr[indexPath.row]
        imageView.image = UIImage.init(named: imageName)


        
        return cell
    }
    /// collectsion banner Api
    func getBannerList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getCategorycollections , method: .get).responseJSON
            { [self] response in
                

                
                if let result = response.result.value {
                    if response.result.isSuccess {
                        
                        let JSON = result as! NSArray

                    
                        let statusCode = response.response!.statusCode
                        
                        KRProgressHUD.dismiss()

                       // self.imageArr.removeAll()
                        

                    
                        
                        if(JSON != nil){



                        for user in JSON
                        {
                            
                           print(user)

                            let category_image = (user as AnyObject).value(forKey: AppURL.categorybanners) as! String
                           // imageArr.append(category_image)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        }
                    }
                }
            }
    }

}
