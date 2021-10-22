//
//  BankDetailsViewController.swift
//  Yaari
//
//  Created by Mac on 18/10/21.
//

import UIKit
import AVFoundation
import Photos

class BankDetailsViewController: UIViewController {
    @IBOutlet weak var stackViewhelp: UIStackView!
    @IBOutlet weak var heightConstraintAccountNo: NSLayoutConstraint!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var textFieldIFSC: UITextField!
    @IBOutlet weak var textFieldConfirmAccountNo: UITextField!
    @IBOutlet weak var textFieldAccountHolder: UITextField!
    @IBOutlet weak var viewConfirmAccountNo: UIView!
    @IBOutlet weak var textfieldAccountNo: UITextField!
    @IBOutlet var chequeImageView: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bank Details"
        // Do any additional setup after loading the view.
        textfieldAccountNo.setLeftPaddingPoints(10)
        textFieldConfirmAccountNo.setLeftPaddingPoints(10)
        textFieldAccountHolder.setLeftPaddingPoints(10)
        textFieldIFSC.setLeftPaddingPoints(10)
        picker.delegate = self
        disableForm()
        //let button1 = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action:  #selector(btnMenuAction))
        let button1 = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(btnEditAction))
        self.navigationItem.rightBarButtonItem  = button1

        
        
        let button2 = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backBtnAction))
        // action:#selector(Class.MethodName) for swift 3
        
        self.navigationItem.leftBarButtonItem  = button2
    }
    @objc func backBtnAction() {
        self.tabBarController?.tabBar.isHidden = false

        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDeleteAction(_ sender: Any) {
        chequeImageView.image  = nil
        chequeImageView.isHidden = true
        btnDelete.isHidden = true
    }
    func disableForm() {
        viewConfirmAccountNo.isHidden = true
        stackViewhelp.isHidden = true
        btnSave.isHidden = true
        heightConstraintAccountNo.constant = 0
        textfieldAccountNo.isUserInteractionEnabled = false
        textFieldAccountHolder.isUserInteractionEnabled = false
        textFieldIFSC.isUserInteractionEnabled = false
        chequeImageView.isHidden = true
        btnDelete.isHidden = true
        
    }
    func enableForm() {
        viewConfirmAccountNo.isHidden = false
        stackViewhelp.isHidden = false
        btnSave.isHidden = false
        heightConstraintAccountNo.constant = 80
        textfieldAccountNo.isUserInteractionEnabled = true
        textFieldAccountHolder.isUserInteractionEnabled = true
        textFieldIFSC.isUserInteractionEnabled = true
    }
    @objc func btnEditAction() {
        enableForm()
        let button1 = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(btnDoneAction))
        self.navigationItem.rightBarButtonItem  = button1
    }
    @objc func btnDoneAction() {
        disableForm()
        let button1 = UIBarButtonItem.init(title: "Edit", style: .plain, target: self, action: #selector(btnEditAction))
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    @IBAction func btnUploadPhotoAction(_ sender: Any) {
        
        let cameraPermission = checkCameraPermission()
        let gallaryPermission = checkPhotoLibraryPermission()
        
        if cameraPermission || gallaryPermission{
            self.showActionSheet()
        }
        else {
            AlertManager.ShowAlertWithOk(title: AlertMessages.MessageTitle.rawValue, message: AlertMessages.needPermissionMsg.rawValue, presentedViewController: self)
        }
        
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
        } else{
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSaveAndContinueAction(_ sender: Any) {
    }
}
extension BankDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

      
        if let originalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chequeImageView.isHidden = false
            btnDelete.isHidden = false
            
            
            
            chequeImageView.image = originalImg
            chequeImageView.contentMode = .scaleToFill
            //print("width \(logoImageView.frame.width) height \(logoImageView.frame.height)")
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       dismiss(animated: true, completion: nil)
    }
}
