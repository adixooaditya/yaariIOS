//
//  FiltersViewController.swift
//  Yaari
//
//  Created by Mac on 03/09/21.
//




import UIKit
import BottomPopup
import Alamofire
import KRProgressHUD


protocol FiltersViewControllerDelegate {
    func sendData(setcategoryFilter: String,selectValueArray:[Int],collecstionId:String)
    
   }


class FiltersViewController: BottomPopupViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    @IBOutlet weak var tableViewFilter: UITableView!
    
    var getcategoryId = String()
    var arrayName = [String]()
    var categoryId = [String]()
    var categoryColor = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    let arrayFilter = ["Category","Fabric","Color","Price","Discount","Size","Combo","Material)","Pattern or print type","Sleeve","Neck"]
    var priceArray = [String]()
    var DisCountArray = [String]()
    var sizeArray = [String]()
    
    
    var arrSelectedRows:[String] = []
    var setIndex = Int()
    
    
    var searching = false
    
    var searchedCategoryArray = [String]()
    
    
    
    
    
    
    var selectValueArray = [String]()
    
  
    var userSetFilterArray = [Int]()
    
    var delegate: FiltersViewControllerDelegate?
    var getcollecstionId = String()



    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewFilter.delegate = self
        tableViewFilter.dataSource = self
        
        
        self.searchBar.delegate = self
        
      
      
        
        getCategoryList()
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
    
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
   
    @IBAction func btnApplyAction(_ sender: Any) {
       
        
        
        if setIndex == 0{
        let filtercategoryId = selectValueArray.joined(separator: ",")
        print(filtercategoryId)
        }else{
          
            print(selectValueArray)
        
        var setcategoryFilter = "2"
        
        
        
       
        
            self.delegate?.sendData(setcategoryFilter: setcategoryFilter, selectValueArray: userSetFilterArray, collecstionId: getcollecstionId)
            self.presentingViewController!.dismiss(animated: true, completion: nil)

        
          
//       print(userSetFilterArray)
//
//                 let popupVC = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
//                popupVC.priceFilterArray = userSetFilterArray
//                popupVC.setcategoryFilter = setcategoryFilter
//
//                present(popupVC, animated: true, completion: nil)
        }
      
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var strcount = Int()
        if tableView == self.tableViewFilter {
            strcount = arrayFilter.count
        }
        else{
            
            if  searchBar.text != "" {
                strcount = searchedCategoryArray.count
                
            }
            else{
                
                strcount = arrayName.count
                
                
                
            }
            
            
        }
        return strcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.tableViewFilter {
            let cell   = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! CategoryFilterTableViewCell
            cell.lblTitle.text = arrayFilter[indexPath.row]
            cellToReturn = cell
        }
        else {
            let cell   = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as! SortTableViewCell
            
            
            if  searchBar.text != "" {
                cell.lblTitle.text = searchedCategoryArray[indexPath.row]
                
                
                
                
                
                if setIndex == 2{
                    
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                    cell.btnSelect.backgroundColor = hexStringToUIColor(hex: categoryColor[indexPath.row])
                }else  if setIndex == 3{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }
                else  if setIndex == 4{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }else  if setIndex == 5{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }
                
                else{
                    cell.btnSelect.backgroundColor = .clear
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
                  
//                    if setIndex == 0{
//                        self.tableView.allowsMultipleSelection = true
//
//                    }
                }
                
                
                
                
            }else{
                print(arrayName.count)
                cell.lblTitle!.text! = arrayName[indexPath.row]
                
                print(cell.lblTitle!.text!)
                
                
                
                if setIndex == 2{
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                    cell.btnSelect.backgroundColor = hexStringToUIColor(hex: categoryColor[indexPath.row])
                }else  if setIndex == 3{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }
                else  if setIndex == 4{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }else  if setIndex == 5{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                    cell.btnSelect.backgroundColor = .clear
                }
                
                else{
                    cell.btnSelect.backgroundColor = .clear
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
//                    if setIndex == 0{
//                        self.tableView.allowsMultipleSelection = true
//
//                    }
                    
                }
                
                
                
                
            }
            
            cellToReturn = cell
            
            
        }
        return  cellToReturn
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewFilter {
            if indexPath.row == 0{
                setIndex = 0
                getCategoryList()
            }
            else if indexPath.row == 1{
                setIndex = 1
                getFabricList()
            }
            
            else if indexPath.row == 2{
                setIndex = 2
                getColorList()
            }
            else if indexPath.row == 3{
                setIndex = 3
                getPriceList()
            }
            else if indexPath.row == 4{
                setIndex = 4
                getDiscountList()
            }
            else if indexPath.row == 5{
                setIndex = 5
                getSizeList()
                
            }
            else if indexPath.row == 6{
                setIndex = 6
            }
            
            else if indexPath.row == 7{
                setIndex = 7
                getMaterialList()
            }
            else if indexPath.row == 8{
                setIndex = 8
            }
            else if indexPath.row == 9{
                setIndex = 9
            }
            else if indexPath.row == 10{
                setIndex = 10
            }
            
        }else {
            let cell = tableView.cellForRow(at: indexPath) as!SortTableViewCell
            if setIndex == 0{
                if searchBar.text != "" {
                    selectValueArray.removeAll()
                    let id = categoryId[indexPath.row]
                    selectValueArray.append(id)
                    
                    cell.btnSelect.setImage(UIImage(named:"Layer 1144"), for: .normal)
                    
                    
                    
                    
                    
                    
                }else{
                    selectValueArray.removeAll()
                    let id = categoryId[indexPath.row]
                    selectValueArray.append(id)
                    
                    cell.btnSelect.setImage(UIImage(named:"Layer 1144"), for: .normal)
                    
                    
                }
                
            }
            else if setIndex == 2{
                if searchBar.text != "" {
                    
                    
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                    
                    
                    
                    //radio-on-button (1)
                    
                    
                }else{
                    
                    
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                    
                    
                }
            }
            else if setIndex == 3{
                if searchBar.text != "" {
                    
                    if indexPath.row == 0{
                       
                        userSetFilterArray = [0,500]
                    }else  if indexPath.row == 1{
                        userSetFilterArray = [500,750]
                    }else  if indexPath.row == 2{
                        userSetFilterArray = [750,1000]
                    }else  if indexPath.row == 3{
                        userSetFilterArray = [1000,1500]
                    }else  if indexPath.row == 4{
                        userSetFilterArray = [1500]
                    }
                   
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                    
                    //radio-on-button (1)
                    
                    
                }else{
                    
                    selectValueArray.removeAll()
                    if indexPath.row == 0{
                       
                        userSetFilterArray = [0,500]
                    }else  if indexPath.row == 1{
                        userSetFilterArray = [500,750]
                    }else  if indexPath.row == 2{
                        userSetFilterArray = [750,1000]
                    }else  if indexPath.row == 3{
                        userSetFilterArray = [1000,1500]
                    }else  if indexPath.row == 4{
                        userSetFilterArray = [1500]
                    }
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                }
            }
            else if setIndex == 4{
                if searchBar.text != "" {
                    
                    
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                    
                    //radio-on-button (1)
                    
                    
                }else{
                    
                    
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                }
            }
            else if setIndex == 5{
                if searchBar.text != "" {
                    
                    
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                    
                    
                    
                }else{
                    
                    
                    cell.btnSelect.setImage(UIImage(named:"radio-on-button (1)"), for: .normal)
                    
                    
                }
            }else{
                if searchBar.text != "" {
                    
                    cell.btnSelect.setImage(UIImage(named:"Layer 1144"), for: .normal)
                    
                    
                    
                    
                    
                    
                }else{
                    
                    
                    cell.btnSelect.setImage(UIImage(named:"Layer 1144"), for: .normal)
                    
                    
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewFilter {
            
        }
        else {
            let cell = tableView.cellForRow(at: indexPath) as!SortTableViewCell
            if setIndex == 0{
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
                }
            }
            else if setIndex == 2{
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:""), for: .normal)
                }
            }
            else if setIndex == 3{
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
            }
            else if setIndex == 4{
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
            }
            else if setIndex == 5{
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:"Radiobtn"), for: .normal)
                }
            }
            
            else {
                if searchBar.text != "" {
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
                }
                else{
                    cell.btnSelect.setImage(UIImage(named:"Layer 1143"), for: .normal)
                }
            }
            
            
            
        }
        
    }
    
    /// getMateriallist
    func getMaterialList() {
        searchedCategoryArray.removeAll()
        arrayName.removeAll()
        
        
        
        arrayName = ["Metal","Steel","Glass","Plastic","Aluminium","Texttile","Silcon","Copper","Paper","Timber","Iron"]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
        
    }
    
    
    /// getFabriclist
    func getFabricList() {
        searchedCategoryArray.removeAll()
        arrayName.removeAll()
        
        
        
        arrayName = ["Denim","Velvet","Jeans","Damask","Tartan","Chiffon"]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.allowsMultipleSelection = false

            
        }
        
        
        
    }
    
    
    
    /// getPricelist
    func getPriceList() {
        searchedCategoryArray.removeAll()
        arrayName.removeAll()
        
        
        
        arrayName = ["Under ₹500","₹500 to ₹750","₹750 to ₹1000","₹1000 to ₹1500","Over ₹1500"]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.allowsMultipleSelection = false
        }
        
        
        
    }
    
    
    /// getDisCountlist
    func getDiscountList() {
        searchedCategoryArray.removeAll()
        arrayName.removeAll()
        
        
        arrayName = ["10% Off or more","20% Off or more","30% Off or more","40% Off or more","50% Off or more","60% Off or more","70% Off or more","80% Off or more"]
        
        
        
        
        self.tableView.reloadData()
        self.tableView.allowsMultipleSelection = false
        
        
        
    }
    /// getSizetlist
    func getSizeList() {
        searchedCategoryArray.removeAll()
        arrayName.removeAll()
        
        arrayName = ["S","M","L","XL","XXL"]
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.allowsMultipleSelection = false
        }
        
        
    }
    
    
    
    /// getcolorlist Api
    func getColorList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getcolors, method: .get).responseJSON
        { [self] response in
            
            print(response)
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    let JSON = result as! NSArray
                    
                    
                    let statusCode = response.response!.statusCode
                    
                    KRProgressHUD.dismiss()
                    
                    self.arrayName.removeAll()
                    self.categoryId.removeAll()
                    self.categoryColor.removeAll()
                    
                    
                    
                    
                    
                    
                    if(JSON != nil){
                        
                        
                        
                        for user in JSON
                        {
                            
                            print(user)
                            
                            let id1 = (user as AnyObject).value(forKey: "id") as AnyObject
                            let id = String(describing: id1)
                            categoryId.append(id)
                            let name = (user as AnyObject).value(forKey: "name") as! String
                            
                            arrayName.append(name)
                            let hex = (user as AnyObject).value(forKey: "hex") as! String
                            
                            categoryColor.append(hex)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.allowsMultipleSelection = false
                        }
                    }
                }
            }
        }
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
                    
                    self.arrayName.removeAll()
                    self.categoryId.removeAll()
                    self.categoryColor.removeAll()
                    
                    
                    
                    
                    
                    
                    if(JSON != nil){
                        
                        
                        
                        for user in JSON
                        {
                            
                            print(user)
                            
                            let category_id1 = (user as AnyObject).value(forKey: AppURL.categoryId) as AnyObject
                            let category_id = String(describing: category_id1)
                            print(category_id)
                            categoryId.append(category_id)
                            let category_name = (user as AnyObject).value(forKey: AppURL.categoryName) as! String
                            arrayName.append(category_name)
                            categoryColor.append("")
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.allowsMultipleSelection = true
                        }
                    }
                }
            }
        }
    }
    
    
}

extension FiltersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedCategoryArray = arrayName.filter { $0.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
        
        
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        
        
        
        
        
        
    }
    
    
}

