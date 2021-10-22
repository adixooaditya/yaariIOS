//
//  CategoryFilterViewController.swift
//  Yaari
//
//  Created by Mac on 03/09/21.
//


import UIKit
import BottomPopup
import Alamofire
import KRProgressHUD
import SDWebImage

struct Category {
    
    var category_id:String
    var category_name: String
    
    
}

struct CategoryFilter {
    
    var categoryId:String
    
    
}
protocol CategoryFilterViewControllerDelegate {
    func messageData(setcategoryFilter: String,selectValueArray:[Int])
    
   }


class CategoryFilterViewController: BottomPopupViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    
    var array = [Category]()
    
    var arrSelectedRows:[Int] = []
    var getcategoryId = String()
    var getsubcategoryId = String()
    
    var categoryFilterArray = [CategoryFilter]()
    var cateroryfilter = [String]()
    var selectValueArray = [Int]()
    
    public static var userFilterCategoryId:String?
    public static var userFilterCategorysetValue:String?

    
    var delegate: CategoryFilterViewControllerDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategoryList()
        
        // Do any additional setup after loading the view.
    }
    
    override var popupHeight: CGFloat { return height ?? CGFloat(300) }
    
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(10) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 1.0 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 1.0 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
    // override var popupDimmingViewAlpha: CGFloat { return BottomPopupConstants.kDimmingViewDefaultAlphaValue }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func btnCloseAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func btnApplyAction(_ sender: Any) {
        
        var setcategoryFilter = "1"
        
        
        
        
        self.delegate?.messageData(setcategoryFilter: setcategoryFilter, selectValueArray: selectValueArray)
        self.presentingViewController!.dismiss(animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as! SortTableViewCell
        cell.lblTitle.text = array[indexPath.row].category_name
        
        
        
        
        cell.btnSelect.backgroundColor = .clear
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as!SortTableViewCell
        
        let id = array[indexPath.row].category_id
        selectValueArray.append(Int(id)!)
        cell.btnSelect.setImage(UIImage(named:"Layer 1144"), for: .normal)
        
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as!SortTableViewCell
        
        cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
        
        
        
    }
    
    
    
    
    /// categorylist Api
    func getCategoryList() {
        KRProgressHUD.show()
        let id = "/" + getcategoryId
        Alamofire.request(AppURL.getcategories, method: .get).responseJSON
        { [self] response in
            
            print(response)
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    let JSON = result as! NSArray
                    
                    
                    let statusCode = response.response!.statusCode
                    
                    KRProgressHUD.dismiss()
                    
                    self.array.removeAll()
                    
                    
                    
                    
                    if(JSON != nil){
                        
                        
                        
                        for user in JSON
                        {
                            
                            print(user)
                            
                            let category_id1 = (user as AnyObject).value(forKey: AppURL.categoryId) as AnyObject
                            let category_id = String(describing: category_id1)
                            print(category_id)
                            let category_name = (user as AnyObject).value(forKey: AppURL.categoryName) as! String
                            self.array.append(Category(category_id: category_id, category_name: category_name))
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    /// subcategorylist Api
    /// parmaeters categoryId
    func getSubCategoryList(categoryId:String) {
        KRProgressHUD.show()
        let id = "/" + categoryId
        Alamofire.request(AppURL.getsubcategoriescollections + id , method: .get).responseJSON
        { [self] response in
            
            
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    
                    
                    let statusCode = response.response!.statusCode
                    
                    KRProgressHUD.dismiss()
                    
                    let subcategoryId1 = (result as AnyObject).value(forKey: AppURL.subcategoryId) as AnyObject
                    self.getsubcategoryId = String(describing: subcategoryId1)
                    
                    
                    dismiss(animated: true, completion: nil)
                    
                    
                    
                    
                }
            }
        }
    }
    
    
}

