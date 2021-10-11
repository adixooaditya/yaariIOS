//
//  ProductListViewController.swift
//  Yaari
//
//  Created by Mac on 31/08/21.
//

import UIKit
import BottomPopup

class ProductListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, BottomPopupDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var titleStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleStr
       
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
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
       // cell.backgroundColor = UIColor.gray
        return cell
    }
}
