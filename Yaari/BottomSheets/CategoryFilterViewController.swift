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

class CategoryFilterViewController: BottomPopupViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
//    let array = ["Indian & Fusion Wear (170542)","Western Wear (170542)","Footwear (170542)","Sports & Active Wear (170542)","Lingerie & Sleepwear (170542)","Beauty & Personal Care (170542)","Jewellery (170542)","Gadgets (170542)","Boys Clothing (170542)","Girls Clothing (170542)","Boys Footwear (170542)","Girls Footwear (170542)","Infants (170542)","Kids Accessories (170542)","Innerwear & Sleepwear (170542)"]
    
    
    var array = [Category]()
    
    var arrSelectedRows:[Int] = []


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
        dismiss(animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as! SortTableViewCell
        cell.lblTitle.text = array[indexPath.row].category_name
        
        let id = array[indexPath.row].category_id
        let strid = Int(id)

        if arrSelectedRows.contains(strid!){
            cell.btnSelect.setBackgroundImage(UIImage(named:"radio-on-button (1)"), for: .normal)
        }else{
            cell.btnSelect.setBackgroundImage(UIImage(named:"Radiobtn"), for: .normal)
        }
        cell.btnSelect.tag = strid!
        cell.btnSelect.addTarget(self, action: #selector(checkBoxSelection(_:)), for: .touchUpInside)

        return cell
        
    }
    
    @objc func checkBoxSelection(_ sender:UIButton)
    {

        if self.arrSelectedRows.contains(sender.tag){
            self.arrSelectedRows.remove(at: self.arrSelectedRows.index(of: sender.tag)!)
        }else{
            self.arrSelectedRows.append(sender.tag)
            
            print(arrSelectedRows)

        }
        self.tableView.reloadData()
    }

    
    /// categorylist Api
    func getCategoryList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getcategories , method: .get).responseJSON
            { [self] response in
                

                
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

}

