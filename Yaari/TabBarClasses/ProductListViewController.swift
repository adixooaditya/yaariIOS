//
//  ProductListViewController.swift
//  Yaari
//
//  Created by Mac on 31/08/21.
//

import UIKit
import BottomPopup
import Alamofire
import KRProgressHUD
import SDWebImage

struct productList {
    
    var id:String
    var name: String
    var price: String
    var sellingPrice: String
    var images:[String]



}




class ProductListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, BottomPopupDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var titleStr = ""
    var getcategoryId = String()
    var getsubcategory_id = String()
    
    var productListArray = [productList]()
    /// Initializing All the Objects
    func initialization() {
        self.title = titleStr
        print(getcategoryId)
       
        self.tabBarController?.tabBar.isHidden = true

        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        // Do any additional setup after loading the view.
        
        let cellWidth : CGFloat = collectionView.frame.size.width / 2.0 - 5.0
        let cellheight : CGFloat = 302 //collectionViewBottom.frame.size.height / 3.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.setCollectionViewLayout(layout, animated: true)

        collectionView.reloadData()
        
        getProductList()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true

        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnGenderAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "GenderViewController") as? GenderViewController else { return }
        popupVC.height = 300
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
        
        
        
    }
    @IBAction func btnSortAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SortViewController") as? SortViewController else { return }
        popupVC.height = 220
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func btnCategoryAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "CategoryFilterViewController") as? CategoryFilterViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
        
    }
    @IBAction func btnFiltersAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "FiltersViewController") as? FiltersViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
       // cell.backgroundColor = UIColor.gray
        
        let imageView = cell.contentView.viewWithTag(101) as! UIImageView
        
        let getString = productListArray[indexPath.row].images[0]
        let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)

        imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)

        
        
        imageView.contentMode  = .scaleAspectFit
        let lblName = cell.contentView.viewWithTag(102) as! UILabel
        lblName.text = productListArray[indexPath.row].name
        
        let lbldes = cell.contentView.viewWithTag(103) as! UILabel
        lbldes.text = productListArray[indexPath.row].sellingPrice

        
        let lbldes1 = cell.contentView.viewWithTag(104) as! UILabel
        lbldes1.text = productListArray[indexPath.row].price

        
        return cell
    }
    
    /// productlist Api
    func getProductList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getproducts , method: .get).responseJSON
            { [self] response in
                
                print(response)
                

                
                if let result = response.result.value {
                    if response.result.isSuccess {
                        
                        let JSON = result as! NSArray

                    
                        let statusCode = response.response!.statusCode
                        
                        KRProgressHUD.dismiss()

                       // self.topArray.removeAll()
                        

                    
                        
                        if(JSON != nil){



                        for user in JSON
                        {
                            
                           print(user)
                            



                            let productid1 = (user as AnyObject).value(forKey: AppURL.productid) as AnyObject
                            let productid = String(describing: productid1)
                            let productname = (user as AnyObject).value(forKey: AppURL.productname) as! String
                            
                            let productprice1 = (user as AnyObject).value(forKey: AppURL.productprice) as AnyObject
                            let productprice = String(describing: productprice1)

                            let productsellingPrice1 = (user as AnyObject).value(forKey: AppURL.productsellingPrice) as AnyObject
                            let productsellingPrice = String(describing: productsellingPrice1)

                            
                            
                            
                            let productimages = (user as AnyObject).value(forKey: AppURL.productimages) as! NSArray
                            self.productListArray.append(productList(id: productid, name: productname, price: productprice, sellingPrice: productsellingPrice, images: productimages as! [String]))
                        }
                        DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        }
                        }
                    }
                }
            }
    }

}
