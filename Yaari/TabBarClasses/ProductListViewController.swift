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

struct collectsionIdList {
    
    var collectionId:String
    
    
    
}



class ProductListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, BottomPopupDelegate,FavoutiesDelegetes,CategoryFilterViewControllerDelegate,FiltersViewControllerDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titleStr = ""
    var getcategoryId = String()
    var getfiltercategoryId = String()
    var getsubcategory_id = String()
    
    var productListArray = [productList]()
    var getsubcategoryId = String()
    var collectsionIdArray = [collectsionIdList]()
    
    var filtercategoryId = String()
    var setcategoryFilter = String()
    
    var strvalue:String!
    var getToken = String()
    var getWishlistId = String()
    
    var selectValueArray = [Int]()
    var jsonString:AnyObject!
    var priceFilterArray = [Int]()
    
    
    /// Initializing All the Objects
    func initialization() {
        
        if getToken.isEmpty {
            getToken = UserDefaults.standard.string(forKey: AppURL.token)!
        }
        
        getWislist(token: getToken)
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
        vc.getproductId = productListArray[indexPath.row].id
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        
        
    }
    
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
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
        popupVC.getcategoryId = getcategoryId
        popupVC.delegate = self
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
        popupVC.getcategoryId = getcategoryId
        popupVC.getcollecstionId = getfiltercategoryId
        popupVC.delegate = self
        
        present(popupVC, animated: true, completion: nil)
    }
    func LikeButton(sender: ptoductListTVS) {
        KRProgressHUD.show()
        
        var cel = ptoductListTVS()
        let cell = sender.tag
        let buttonPosition = sender.convert(CGPoint.zero, to: collectionView)
        print(buttonPosition)
        guard let indexPath = self.collectionView.indexPathForItem(at: buttonPosition) else {
            return
        }
        print(indexPath.row)
        let currentCell = collectionView.cellForItem(at: indexPath) as! ptoductListTVS
        
        let parametersBal: Parameters=[
            AppURL.wishlistproductId:Int(productListArray[indexPath.row].id),
            AppURL.wishlistquantity:1,
            AppURL.wishlistId:Int(getWishlistId)
            
        ]
        print(parametersBal)
        Alamofire.request(AppURL.Addwishlist, method: .post, parameters: parametersBal,encoding: JSONEncoding.default).responseJSON
        {
            
            
            
            
            response in
            print(response)
            
            if let result = response.result.value {
                
                
                let statusCode = response.response!.statusCode
                
                KRProgressHUD.dismiss()
                
                
                
                print(statusCode)
                if (statusCode == 201)
                {
                    
                    sender.btnlike.setImage(UIImage(named: "heart (1)"), for: .normal)
                    DispatchQueue.main.async { [self] in
                        self.getProductList()
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
                
                else{
                    KRProgressHUD.dismiss()
                    
                    //AlertManager.ShowAlertWithOk(title: "Product List", message: message,presentedViewController: self)
                    
                }
                
            }
            
            
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // return CGSize(width: 170, height: 250)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ptoductListTVS
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.size.width
        let cellWidth = screenWidth/1.3
        let size = CGSize(width: cellWidth, height: cell!.contentView.layer.bounds.height)
        return size
        
        
        
        
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ptoductListTVS
        cell.editData = self
        
        let getString = productListArray[indexPath.row].images[0]
        let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)
        
        cell.userImage.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)
        
        
        
        cell.userImage.contentMode  = .scaleAspectFit
        cell.userNamelbl.text = productListArray[indexPath.row].name
        
        cell.sellingpricelbl.text = productListArray[indexPath.row].sellingPrice
        
        
        cell.pricelbl.text = productListArray[indexPath.row].price
        
        
        return cell
    }
    
    
    func messageData(setcategoryFilter: String, selectValueArray: [Int]) {
        self.selectValueArray = selectValueArray
        self.setcategoryFilter = setcategoryFilter
        getProductList()
    }
    //getcollecstionId
    func sendData(setcategoryFilter: String, selectValueArray: [Int],collecstionId: String) {
        self.priceFilterArray = selectValueArray
        self.setcategoryFilter = setcategoryFilter
        getfiltercategoryId = collecstionId
        getProductList()
    }


    
    /// productlist Api using filter
    /// parameters
    func getProductList() {
        
    
        
        KRProgressHUD.show()
        
        //filtercategoryId
        print(setcategoryFilter)
        
        if(setcategoryFilter == "1"){
            jsonString = categoryfliterList(categoryId: filtercategoryId, selectValueArray: selectValueArray)
            print(jsonString!)
            
        }
        else if(setcategoryFilter == "2"){
            jsonString = pricefliterList(priceFilterArray:priceFilterArray,collectsionId: getfiltercategoryId)
            print(jsonString!)
            
        }
        else if(setcategoryFilter == "3"){
            jsonString = fliterSubCategory(subCategoryId: getsubcategory_id)
            print(jsonString!)
            
        }
        
        else{
            jsonString = fliter(collectsionId: getfiltercategoryId)
            print(jsonString!)
            
            
        }
        
        
        Alamofire.request(AppURL.getproducts, method: .get,parameters: [AppURL.filter:jsonString!]).responseJSON
        { [self] response in
            
            
            print(response)
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    let JSON = result as! NSArray
                    
                    
                    let statusCode = response.response!.statusCode
                    
                    KRProgressHUD.dismiss()
                    
                    self.productListArray.removeAll()
                    
                    
                    
                    
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
    
    
    /// wishlist Api get user Details according token
    /// perameters
    /// userId
    func getWislist(token:String) {
        
        let strvalue1 = decode(jwtToken: token)
        
        let id1 = (strvalue1 as AnyObject).value(forKey: "id") as AnyObject
        let userId = String(describing: id1)
        print(userId)
        
        
        
        
        
        KRProgressHUD.show()
        
        let parametersBal: Parameters = [
            AppURL.getuserId:Int(userId)
        ]
        
        
        
        Alamofire.request(AppURL.getwishlist, method: .post,parameters:parametersBal,encoding: JSONEncoding.default).responseJSON
        { [self] response in
            
            print(response)
            
            
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    
                    
                    let statusCode = response.response!.statusCode
                    
                    KRProgressHUD.dismiss()
                    
                    let id = (result as AnyObject).value(forKey: AppURL.getwishlistId) as AnyObject
                    getWishlistId = String(describing: id)
                    print(getWishlistId)
                    
                    
                    
                }
            }
        }
    }
    
    
}

protocol FavoutiesDelegetes {
    
    func LikeButton(sender:ptoductListTVS)
}

class ptoductListTVS:UICollectionViewCell{
    
    @IBOutlet weak var numberoffpersonlbl: UILabel!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var freedeliverylbl: UILabel!
    @IBOutlet weak var perstageofflbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var sellingpricelbl: UILabel!
    @IBOutlet weak var addvaluelbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    var editData: FavoutiesDelegetes?
    var indexPath : IndexPath?
    
    @IBAction func btnLike(_ sender: Any) {
        self.editData?.LikeButton(sender: self)
        
    }
}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
