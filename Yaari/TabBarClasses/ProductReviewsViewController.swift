//
//  ProductReviewsViewController.swift
//  Yaari
//
//  Created by Mac on 16/09/21.
//

import UIKit
import Alamofire
import SDWebImage
import KRProgressHUD

class ProductReviewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var ReviewsArray = [Commment]()
    var getproductId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Reviews"
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        
        getProductComments()
        // Do any additional setup after loading the view.
    }
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReviewsArray.count
       
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)as! Reviews
         
        // cell.userNamelbl.text = ReviewsArray[indexPath.row].comment

         cell.deslbl.text = ReviewsArray[indexPath.row].comment
        return cell
        
    }
    /// Commenets Api
    func getProductComments() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getProductDetailscomments , method: .get).responseJSON
            { [self] response in
                
                print(response)
                

                
                if let result = response.result.value {
                    if response.result.isSuccess {
                        
                        KRProgressHUD.dismiss()
                        
                        let statusCode = response.response!.statusCode

                        if statusCode == 200{
                            ReviewsArray.removeAll()
                        
                            let JSON = result as! NSArray
                            
                            for user in JSON{
                                
                                let userId1 = (user as AnyObject).value(forKey: AppURL.userId) as AnyObject
                                let userId = String(describing: userId1)
                                
                                getUser(userid: userId)

                                let comment = (user as AnyObject).value(forKey: AppURL.comment) as! String
                            var description = String()

                                if  let description1 = (user as AnyObject).value(forKey: AppURL.description) as? String{
                                description = description1
                            }else{
                                
                            }

                                let productId1 = (user as AnyObject).value(forKey: AppURL.productid) as AnyObject
                                let productId = String(describing: productId1)
                                
                                //if(productId == getproductId){

                                ReviewsArray.append(Commment(comment: comment, description: description, userId: userId,productId: productId))
                                //}
                                
                                
                                

                            }
                            DispatchQueue.main.async {
                                tableView.reloadData()
                                
                            }

                            
           
                        }
                        
                        

                    
                    }
                }
            }
    }

    
    
    /// Normal user Api with userid
    /// - Parameter userid
    func getUser(userid: String) {
        KRProgressHUD.show()

        let id = "/" + userid
        Alamofire.request(AppURL.getusers + id, method: .get).responseJSON { [self]
            response in
            print(response)
            if response.result.isSuccess {
                if let result = response.result.value {

                    let statusCode = response.response!.statusCode
                    print(statusCode)

                    if statusCode == 200 {
                        KRProgressHUD.dismiss()
                        
                        
                        let firstName = (result as AnyObject).value(forKey: AppURL.firstName) as! String


                        

                    } else {
                        KRProgressHUD.dismiss()

                        

                    }
                }
            }
        }
    }

}
class Reviews:UITableViewCell{
    
    @IBOutlet weak var deslbl: UILabel!
    @IBOutlet weak var verifylbl: UIImageView!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var userNamelbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
}
