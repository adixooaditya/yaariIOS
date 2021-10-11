//
//  ProductDetailViewController.swift
//  Yaari
//
//  Created by Mac on 09/09/21.
//


import UIKit
import SideMenu
import ScrollingPageControl

class ProductDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {

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
    let topArray = ["Essentials","Woman","Men","Kids","Decore","Kitchen"]
    let topArrayImages = ["essentialsHome","womenHome","menhome","kidshome","decorehome","kitchenhome"]
    let bottomArray = ["Bra & Lingerie","Clothing Sets","Earings","T-shirts","Gadgets","Home & Kitchen"]
    let bottomArrayImages = ["lingeries","clothingsets","earings","demoImg","gadgets","homeKitchen"]
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


//        let cellWidth : CGFloat = collectionViewBottom.frame.size.width / 2.0 - 7.5 //160.0
//        print("cell width \(cellWidth)")
//        let cellheight : CGFloat = 200.0 //collectionViewBottom.frame.size.height / 3.0
//        let cellSize = CGSize(width: cellWidth , height:cellheight)
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //.horizontal
//        layout.itemSize = cellSize
//        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//        layout.minimumLineSpacing = 10.0
//        layout.minimumInteritemSpacing = 5.0
//        collectionViewBottom.setCollectionViewLayout(layout, animated: true)
//
//        collectionViewBottom.reloadData()

        
        // Do any additional setup after loading the view.
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
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableViewReviews:
            return 3
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var items = 0
        switch collectionView {
        case collectionViewTop:
            items = topArray.count
        case collectionViewEssential:
            items = 3
        case collectionViewBottom:
            items = bottomArray.count
        default:
            items = 0
        }
        return items
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewEssential {
            let essentialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "essentialCell", for: indexPath)
            return essentialCell
        }
        else if collectionView == collectionViewTop {
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath)
        let imageView = topCell.contentView.viewWithTag(101) as! UIImageView
        imageView.image = UIImage.init(named: topArrayImages[indexPath.row])
       

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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
