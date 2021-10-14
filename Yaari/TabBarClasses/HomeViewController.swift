//
//  HomeViewController.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import UIKit
import SideMenu
import ScrollingPageControl
import Alamofire
import KRProgressHUD
import SDWebImage



struct CategoryList {
    
    var category_id:String
    var category_name: String
    var category_image: String


}

struct subCategoryList {
    
    var subcategory_id:String
    var subcategory_name: String
    var subcategory_des: String

    var subcategory_image: String


}


class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewBottom: UICollectionView!
    @IBOutlet weak var pageControl: ScrollingPageControl!
    @IBOutlet weak var collectionViewEssential: UICollectionView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    var topArray = [CategoryList]()
   // let bottomArray = ["Bra & Lingerie","Clothing Sets","Earings","T-shirts","Gadgets","Home & Kitchen"]
   var  bottomArray = [subCategoryList]()
    let bottomArrayImages = ["lingeries","clothingsets","earings","demoImg","gadgets","homeKitchen"]


    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        
    }
    
    /// Initializing All the Objects
    func initialization() {
        setLoggedIn()
        setupNavigationBar()
        setupPageControl()
        
        let cellWidth : CGFloat = collectionViewBottom.frame.size.width / 2.0 - 7.5 //160.0
        print("cell width \(cellWidth)")
        let cellheight : CGFloat = 200.0 //collectionViewBottom.frame.size.height / 3.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 5.0
        collectionViewBottom.setCollectionViewLayout(layout, animated: true)

        collectionViewBottom.reloadData()
        
        getCategoryList()
        getSubCategoryList()


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
        btnCart.addTarget(self, action: #selector(HomeViewController.cartButtonPressed), for: .touchUpInside)

        let stackview = UIStackView.init(arrangedSubviews: [btnFavorite,btnNotification,btnCart])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10

        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
         self.title = "Home"

    }
    @objc func cartButtonPressed() {
        let vc = storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        navigationController?.pushViewController(vc, animated: true)
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int!
        if collectionView == collectionViewTop{
            count = topArray.count
        }else if collectionView == collectionViewEssential{
            count = 3
        }
        else if collectionView == collectionViewBottom{
            count = bottomArray.count
        }
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewEssential {
            let essentialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "essentialCell", for: indexPath)
            return essentialCell
        }
        else if collectionView == collectionViewTop {
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath)
        let imageView = topCell.contentView.viewWithTag(101) as! UIImageView
            let getString = topArray[indexPath.row].category_image
            let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)
            imageView.contentMode  = .scaleAspectFit

            imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: ""), options: .forceTransition, progress: nil, completed: nil)


            //imageView.image = UIImage.init(named: getUrl)
        let lblName = topCell.contentView.viewWithTag(102) as! UILabel
            lblName.text = topArray[indexPath.row].category_name

        return topCell
        }
        else if collectionView == collectionViewBottom {
            let bottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
            let imageView = bottomCell.contentView.viewWithTag(101) as! UIImageView
           // imageView.image = UIImage.init(named: bottomArrayImages[indexPath.row])
            
            let getString = bottomArray[indexPath.row].subcategory_image
            let getUrl = getString.replacingOccurrences(of: AppURL.blankSpace, with: AppURL.perTwenty, options: NSString.CompareOptions.literal, range: nil)

            imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: "demoImg"), options: .forceTransition, progress: nil, completed: nil)

            
            
            imageView.contentMode  = .scaleAspectFit
            let lblName = bottomCell.contentView.viewWithTag(102) as! UILabel
            lblName.text = bottomArray[indexPath.row].subcategory_name
            
            let lbldes = bottomCell.contentView.viewWithTag(103) as! UILabel
            lbldes.text = bottomArray[indexPath.row].subcategory_des

            return bottomCell
        }
        else {
            return UICollectionViewCell()
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductListViewController") as! ProductListViewController
        switch collectionView {
        case collectionViewTop:
            vc.titleStr = topArray[indexPath.row].category_name
            vc.getcategoryId = topArray[indexPath.row].category_id

        case collectionViewBottom:
            vc.titleStr = bottomArray[indexPath.row].subcategory_name
            vc.getsubcategory_id = bottomArray[indexPath.row].subcategory_id

        default:
            vc.titleStr = "Product"
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
       let page = round(scrollView.contentOffset.x / scrollView.frame.width)
       pageControl.selectedPage = Int(page)
       
           
            
       }

    
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
        private let cellHeight : CGFloat = 211

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

        //appear and disappear at 0
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

    /// categorylist Api
    func getCategoryList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getCategorycollections , method: .get).responseJSON
            { [self] response in
                

                
                if let result = response.result.value {
                    if response.result.isSuccess {
                        
                        let JSON = result as! NSArray

                    
                        let statusCode = response.response!.statusCode
                        
                        KRProgressHUD.dismiss()

                        self.topArray.removeAll()
                        

                    
                        
                        if(JSON != nil){



                        for user in JSON
                        {
                            
                           print(user)

                            let category_id1 = (user as AnyObject).value(forKey: AppURL.categoryId) as AnyObject
                            let category_id = String(describing: category_id1)
                            print(category_id)
                            let category_name = (user as AnyObject).value(forKey: AppURL.categoryName) as! String
                            let category_image = (user as AnyObject).value(forKey: AppURL.categorybanners) as! String
                            self.topArray.append(CategoryList(category_id: category_id, category_name: category_name, category_image: category_image))
                        }
                        DispatchQueue.main.async {
                            self.collectionViewTop.reloadData()
                        }
                        }
                    }
                }
            }
    }
    
    /// subcategorylist Api
    func getSubCategoryList() {
        KRProgressHUD.show()
        Alamofire.request(AppURL.getsubcategoriescollections , method: .get).responseJSON
            { [self] response in
                

                
                if let result = response.result.value {
                    if response.result.isSuccess {
                        
                        let JSON = result as! NSArray

                    
                        let statusCode = response.response!.statusCode
                        
                        KRProgressHUD.dismiss()

                        self.bottomArray.removeAll()
                        

                    
                        
                        if(JSON != nil){



                        for user in JSON
                        {
                            
                           print(user)


                            let subcategoryId1 = (user as AnyObject).value(forKey: AppURL.subcategoryId) as AnyObject
                            let subcategoryId = String(describing: subcategoryId1)
                            let subcategoryName = (user as AnyObject).value(forKey: AppURL.subcategoryName) as! String
                            let subdescription = (user as AnyObject).value(forKey: AppURL.subdescription) as! String
                            
                            var subcategorybanners = String()

                            if let subcategorybanners1 = (user as AnyObject).value(forKey: AppURL.subcategorybanners) as? String{
                                subcategorybanners = subcategorybanners1
                            }else{
                                
                            }
                            self.bottomArray.append(subCategoryList(subcategory_id: subcategoryId, subcategory_name: subcategoryName, subcategory_des: subdescription, subcategory_image: subcategorybanners))
                        }
                        DispatchQueue.main.async {
                            self.collectionViewBottom.reloadData()
                        }
                        }
                    }
                }
            }
    }


}
