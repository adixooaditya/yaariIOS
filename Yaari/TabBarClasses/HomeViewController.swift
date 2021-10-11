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


struct CategoryList {
    
    var category_id:String
    var category_name: String
    var category_image: String


}

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewBottom: UICollectionView!
    @IBOutlet weak var pageControl: ScrollingPageControl!
    @IBOutlet weak var collectionViewEssential: UICollectionView!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    var topArray = [CategoryList]()
    let bottomArray = ["Bra & Lingerie","Clothing Sets","Earings","T-shirts","Gadgets","Home & Kitchen"]
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
            count = topArray.count
        }
        else if collectionView == collectionViewBottom{
            count = bottomArray.count
        }
//        switch collectionView {
//        case collectionViewTop:
//            items = topArray.count
//        case collectionViewEssential:
//            items = 3
//        case collectionViewBottom:
//            items = bottomArray.count
//        default:
//            items = 0
//        }
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
            
            imageView.sd_setImage(with:URL(string:getUrl), placeholderImage: UIImage(named: ""), options: .forceTransition, progress: nil, completed: nil)


            imageView.image = UIImage.init(named: getUrl)
        let lblName = topCell.contentView.viewWithTag(102) as! UILabel
            lblName.text = topArray[indexPath.row].category_name

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
        let vc = storyboard?.instantiateViewController(identifier: "ProductListViewController") as! ProductListViewController
//        switch collectionView {
//        case collectionViewTop:
//            vc.titleStr = topArray[indexPath.row]
//        case collectionViewBottom:
//            vc.titleStr = bottomArray[indexPath.row]
//        default:
//            vc.titleStr = "Product"
//        }
        navigationController?.pushViewController(vc, animated: true)
        
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
        //this will fade both top and bottom but can be adjusted
//        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//            let attributesSuper: [UICollectionViewLayoutAttributes] = (super.layoutAttributesForElements(in: rect) as [UICollectionViewLayoutAttributes]?)!
//            if let attributes = NSArray(array: attributesSuper, copyItems: true) as? [UICollectionViewLayoutAttributes]{
//                var visibleRect = CGRect()
//                visibleRect.origin = collectionView!.contentOffset
//                visibleRect.size = collectionView!.bounds.size
//                for attrs in attributes {
//                    if attrs.frame.intersects(rect) {
//                        let distance = visibleRect.midX - attrs.center.x
//                        let normalizedDistance = abs(distance) / (visibleRect.width * fadeFactor)
//                        let fade = 1 - normalizedDistance
//                        attrs.alpha = fade
//                    }
//                }
//                return attributes
//            }else{
//                return nil
//            }
//        }
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

}
