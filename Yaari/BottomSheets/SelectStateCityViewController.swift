//
//  SelectStateCityViewController.swift
//  Yaari
//
//  Created by Mac on 08/09/21.
//

import UIKit
import BottomPopup
class SelectStateCityViewController: BottomPopupViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSelect: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var fromState = true
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    let array = ["Indian & Fusion Wear (170542)","Western Wear (170542)","Footwear (170542)","Sports & Active Wear (170542)","Lingerie & Sleepwear (170542)","Beauty & Personal Care (170542)","Jewellery (170542)","Gadgets (170542)","Boys Clothing (170542)","Girls Clothing (170542)","Boys Footwear (170542)","Girls Footwear (170542)","Infants (170542)","Kids Accessories (170542)","Innerwear & Sleepwear (170542)"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromState {
            lblSelect.text = "Select State"
            searchBar.placeholder = "Search State"
        }
        else {
            lblSelect.text = "Select City"
            searchBar.placeholder = "Search City"
        }

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as! SortTableViewCell
        cell.lblTitle.text = array[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
}

