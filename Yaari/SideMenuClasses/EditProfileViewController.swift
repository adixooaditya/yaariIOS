//
//  EditProfileViewController.swift
//  Yaari
//
//  Created by Mac on 22/10/21.
//

import UIKit
import BottomPopup
import AVFoundation
import Photos
class EditProfileViewController: UIViewController,BottomPopupDelegate {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var textFieldFullName: UITextField!
    @IBOutlet weak var textFieldMobileNo: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldLanguage: UITextField!
    @IBOutlet weak var textFieldBusiness: UITextField!
    @IBOutlet weak var textFieldPinCode: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldState: UITextField!

    let picker = UIImagePickerController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        picker.delegate = self
        textFieldFullName.setLeftPaddingPoints(10)
        textFieldMobileNo.setLeftPaddingPoints(10)
        textFieldEmail.setLeftPaddingPoints(10)
        textFieldGender.setLeftPaddingPoints(10)
        textFieldLanguage.setLeftPaddingPoints(10)
        textFieldBusiness.setLeftPaddingPoints(10)
        textFieldPinCode.setLeftPaddingPoints(10)
        textFieldCity.setLeftPaddingPoints(10)
        textFieldState.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCameraAction(_ sender: Any) {
        let cameraPermission = checkCameraPermission()
        let gallaryPermission = checkPhotoLibraryPermission()
        
        if cameraPermission || gallaryPermission{
            self.showActionSheet()
        }
        else {
            AlertManager.ShowAlertWithOk(title: AlertMessages.MessageTitle.rawValue, message: AlertMessages.needPermissionMsg.rawValue, presentedViewController: self)
        }
        
    }
    
    /*
     @IBAction func btnSaveAction(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnCityAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SelectStateCityViewController") as? SelectStateCityViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        popupVC.fromState = false
        present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func btnStateAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "SelectStateCityViewController") as? SelectStateCityViewController else { return }
        popupVC.height = 600
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 0.5
        popupVC.dismissDuration = 0.2
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        popupVC.fromState = true
        present(popupVC, animated: true, completion: nil)
    }
    func showActionSheet() {
        let alert = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title:NSLocalizedString("Gallery", comment: ""), style:.default, handler:{ (_) in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title:NSLocalizedString("Camera", comment: ""), style:.default, handler:{ (_) in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title:NSLocalizedString("Cancel", comment: ""), style:.cancel, handler:{ (_) in
        }))

        self.present(alert, animated: true, completion: { })
    }
        func checkCameraPermission() -> Bool {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                return true
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                    } else {
                    }
                })
                return false
            }
        }

        func checkPhotoLibraryPermission() -> Bool {
            let status = PHPhotoLibrary.authorizationStatus()
            
            if status == .authorized {
                return true
            }
            else if status == .denied {
            }
            else if status == .restricted {
                
            }
            else if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        
                    }
                    else {

                    }
                }
            }
            return false
        }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }

    func openGallery(){
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
   
    
    
}
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

      
        if let originalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewUser.image = originalImg
            //print("width \(logoImageView.frame.width) height \(logoImageView.frame.height)")
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       dismiss(animated: true, completion: nil)
    }
}
