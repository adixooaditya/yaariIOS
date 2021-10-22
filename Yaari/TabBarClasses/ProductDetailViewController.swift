//
//  ProductDetailViewController.swift
//  Yaari
//
//  Created by Mac on 09/09/21.
//


import UIKit
import SideMenu
import ScrollingPageControl
import Alamofire
import SDWebImage
import KRProgressHUD

struct Commment {
    
    var comment:String
    var description: String
    var userId: String
    var productId:String
    
    
    
}


class ProductDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var numberoffpersonlbl1: UILabel!
    @IBOutlet weak var rating1lbl: UILabel!
    @IBOutlet weak var numberoffpersonlbl: UILabel!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var freedeliverylbl: UILabel!
    @IBOutlet weak var perstatageofflbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var sellingpricelbl: UILabel!
    @IBOutlet weak var tableViewReviews: UITableView!
    @IBOutlet weak var tableViewProgress: UITableView!
    @IBOutlet weak var lblEstimatedDelivery: UILabel!
    @IBOutlet weak var stackViewPin: UIStackView!
    @IBOutlet weak var btnShowHideDelivery: UIButton!
    @IBOutlet weak var heightConstraintDelivery: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBottom: UICollectionView!
    @IBOutlet weak var pageControl: ScrollingPageControl!
    @IBOutlet weak var collectionViewEssential: UICollectionView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    var pinCodeFieldVisible  = false
    var topArray = [String]()
    var topArrayImages = [String]()
    let bottomArray = ["Bra & Lingerie","Clothing Sets","Earings","T-shirts","Gadgets","Home & Kitchen"]
    let bottomArrayImages = ["lingeries","clothingsets","earings","demoImg","gadgets","homeKitchen"]
    
    var ReviewsArray = [Commment]()
    var productReview = [AnyObject]()
    
    
    var getproductId = String()
    @IBAction func btnShowHideDeliveryAction(_ sender: Any) {
        if pinCodeFieldVisible {
            hidePinCodeView()
        }
        else {
            showPinCodeView()
        }
        
        
    }
    
    @IBAction func btnViewAllReviewAction(_ sender: Any) {
        let vc =  storyboard?.instantiateViewController(identifier: "ProductReviewsViewController") as! ProductReviewsViewController
        vc.getproductId = getproductId
        navigationController?.pushViewController(vc, animated: true)
    }
    func showPinCodeView() {
        btnShowHideDelivery.setImage(UIImage.init(named: "upArrow"), for: .normal)
        heightConstraintDelivery.constant = 145
        stackViewPin.isHidden = false
        lblEstimatedDelivery.isHidden = false
        pinCodeFieldVisible = true
    }
    func hidePinCodeView() {
        btnShowHideDelivery.setImage(UIImage.init(named: "downArrowBig"), for: .normal)
        heightConstraintDelivery.constant = 50
        stackViewPin.isHidden = true
        lblEstimatedDelivery.isHidden = true
        pinCodeFieldVisible = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupPageControl()
        self.tabBarController?.tabBar.isHidden = true
        hidePinCodeView()
        
        getProductDetails(productId: getproductId)
        
        getProductComments()
        
        
    }
    
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setupPageControl() {
        pageControl.backgroundColor = .clear
        pageControl.selectedColor = .red
        pageControl.centerDots = 1
        pageControl.maxDots = 3
        pageControl.pages = 3
        let layout: UICollectionViewFlowLayout = CollectionViewFlowLayout(scrollDirection: .horizontal)
        collectionViewEssential?.collectionViewLayout = layout
        collectionViewEssential?.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionViewEssential.isPagingEnabled = false
    }
    func setupNavigationBar() {
        
        let button1 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.leftBarButtonItem  = button1
        
        let btnFavorite = UIButton.init(type: .custom)
        btnFavorite.setImage(UIImage(named: "favorites"), for: .normal)
        
        let btnNotification = UIButton.init(type: .custom)
        btnNotification.setImage(UIImage(named: "notifications"), for: .normal)
        
        let btnCart = UIButton.init(type: .custom)
        btnCart.setImage(UIImage(named: "cart"), for: .normal)
        btnCart.addTarget(self, action: #selector(ProductDetailViewController.cartButtonPressed), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [btnFavorite,btnNotification,btnCart])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        self.title = "Details"
        
    }
    @objc func cartButtonPressed() {
        let vc = storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    //    @objc func backBtnAction() {
    //        navigationController?.popViewController(animated: true)
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableViewReviews:
            return ReviewsArray.count
        case tableViewProgress:
            return 5
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewProgress {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! Comments
            // cell.selectionStyle = .none
            
            // cell.userNamelbl.text = ReviewsArray[indexPath.row].comment
            
            cell.deslbl.text = ReviewsArray[indexPath.row].comment
            
            
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var items = 0
        switch collectionView {
        case collectionViewTop:
            items = topArrayImages.count
        case collectionViewEssential:
            items = topArray.count
        case collectionViewBottom:
            items = bottomArray.count
        default:
            items = 0
        }
        return items
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewEssential {
            let essentialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "essentialCell", for: indexPath) as! productDetailsTVC
            
            let getString = topArray[indexPath.row]
            let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)
            
            essentialCell.demoImage.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)
            
            
            
            essentialCell.demoImage.contentMode  = .scaleAspectFit
            
            return essentialCell
        }
        else if collectionView == collectionViewTop {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath)
            let imageView = topCell.contentView.viewWithTag(101) as! UIImageView
            
            let getString = topArrayImages[indexPath.row]
            let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)
            
            imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)
            
            
            
            imageView.contentMode  = .scaleAspectFit
            
            
            
            return topCell
        }
        else if collectionView == collectionViewBottom {
            let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
            let imageView = bottomCell.contentView.viewWithTag(101) as! UIImageView
            imageView.image = UIImage.init(named: bottomArrayImages[indexPath.row])
            imageView.contentMode  = .scaleAspectFit
            let lblName = bottomCell.contentView.viewWithTag(102) as! UILabel
            lblName.text = bottomArray[indexPath.row]
            return bottomCell
        }
        else {
            return UICollectionViewCell()
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.selectedPage = Int(page)
        
        
        
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //
    //        let noOfCellsInRow = 2
    //
    //        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    //
    //        let totalSpace = flowLayout.sectionInset.left
    //            + flowLayout.sectionInset.right
    //            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
    //
    //        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
    //
    //        return CGSize(width: size, height: size)
    //    }
    
    class CollectionViewFlowLayout: UICollectionViewFlowLayout
    {
        
        
        override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
        {
            if let collectionViewBounds = self.collectionView?.bounds
            {
                let halfWidthOfVC = collectionViewBounds.size.width * 0.5
                let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
                if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds)
                {
                    var candidateAttribute : UICollectionViewLayoutAttributes?
                    for attributes in attributesForVisibleCells
                    {
                        let candAttr : UICollectionViewLayoutAttributes? = candidateAttribute
                        if candAttr != nil
                        {
                            let a = attributes.center.x - proposedContentOffsetCenterX
                            let b = candAttr!.center.x - proposedContentOffsetCenterX
                            if abs(a) < abs(b)
                            {
                                candidateAttribute = attributes
                            }
                        }
                        else
                        {
                            candidateAttribute = attributes
                            continue
                        }
                    }
                    
                    if candidateAttribute != nil
                    {
                        return CGPoint(x: candidateAttribute!.center.x - halfWidthOfVC, y: proposedContentOffset.y);
                    }
                }
            }
            return CGPoint.zero
        }
        
        //should be 0<fade<1
        private let fadeFactor: CGFloat = 1.0
        private let cellHeight : CGFloat = 370
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        init(scrollDirection:UICollectionView.ScrollDirection) {
            super.init()
            self.scrollDirection = scrollDirection
            
        }
        
        override func prepare() {
            setupLayout()
            super.prepare()
        }
        
        func setupLayout() {
            let cellWidth =  UIScreen.main.bounds.width
            self.itemSize = CGSize(width: cellWidth,height:cellHeight)
            self.minimumLineSpacing = 0
        }
        
        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            return true
        }
        
        func scrollDirectionOver() -> UICollectionView.ScrollDirection {
            return UICollectionView.ScrollDirection.vertical
        }
        override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            let attributes = super.layoutAttributesForItem(at: itemIndexPath)! as UICollectionViewLayoutAttributes
            attributes.alpha = 0
            return attributes
        }
        
        override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            let attributes = super.layoutAttributesForItem(at: itemIndexPath)! as UICollectionViewLayoutAttributes
            attributes.alpha = 0
            return attributes
        }
        
        
    }
    
    
    /// product Details Api
    /// parameters productId
    func getProductDetails(productId:String) {
        KRProgressHUD.show()
        let strid = "/" + productId
        Alamofire.request(AppURL.getProductDetails + strid , method: .get).responseJSON
        { [self] response in
            
            print(response)
            
            
            
            if let result = response.result.value {
                if response.result.isSuccess {
                    
                    KRProgressHUD.dismiss()
                    
                    let statusCode = response.response!.statusCode
                    
                    if statusCode == 200{
                        topArray.removeAll()
                        topArrayImages.removeAll()
                        
                        
                        
                        let name = (result as AnyObject).value(forKey: AppURL.productname) as! String
                        
                        let sku = (result as AnyObject).value(forKey: AppURL.productDetailssku) as! String
                        var description = String()
                        
                        if  let description1 = (result as AnyObject).value(forKey: AppURL.productDetailsdescription) as? String{
                            description = description1
                        }else{
                            
                        }
                        
                        let price1 = (result as AnyObject).value(forKey: AppURL.productprice) as AnyObject
                        let price = String(describing: price1)
                        
                        pricelbl.text = price + "$"
                        
                        let sellingPrice1 = (result as AnyObject).value(forKey: AppURL.productsellingPrice) as AnyObject
                        let sellingPrice = String(describing: sellingPrice1)
                        
                        sellingpricelbl.text = sellingPrice + "$"
                        
                        let thumbImages = (result as AnyObject).value(forKey: "thumbImages") as! String
                        
                        topArray.append(thumbImages)
                        
                        let images = (result as AnyObject).value(forKey: "images") as! NSArray
                        for user in images{
                            let getImage = user
                            topArrayImages.append(getImage as! String)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.collectionViewTop.reloadData()
                            self.collectionViewEssential.reloadData()
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
            }
        }
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
                        topArray.removeAll()
                        topArrayImages.removeAll()
                        
                        let JSON = result as! NSArray
                        productReview = result as! [AnyObject]
                        
                        
                        for user in JSON{
                            
                            let userId1 = (user as AnyObject).value(forKey: AppURL.userId) as AnyObject
                            let userId = String(describing: userId1)
                            
                            
                            
                            // getUser(userid: userId)
                            
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
                            tableViewReviews.reloadData()
                            
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
class productDetailsTVC:UICollectionViewCell{
    
    @IBOutlet weak var demoImage: UIImageView!
    
}
class Comments:UITableViewCell{
    
    @IBOutlet weak var deslbl: UILabel!
    @IBOutlet weak var verifylbl: UILabel!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNamelbl: UILabel!
}
