//
//  Constants.swift
//  Yaari
//
//  Created by Mac on 05/08/21.
//

import Foundation
import UIKit
struct Colors {
    static let disabledColor = UIColor.init(red: 164/255, green: 164/255, blue: 164/255, alpha: 1.0)
    static let enabledColor = UIColor.init(red: 246/255, green: 33/255, blue: 1/255, alpha: 1.0)

}

struct AppURL {
    static let baseURL = "https://api.halfpricebazar.com/v1/"
    /// singup with otp
    static let singupOtp = baseURL + "otps/generate"
    static let mobile = "mobile"
    static let message = "message"
    static let Signup = "Signup"
    static let setMobile = "Mobile"
    
    static let LoginStatus = "LoginStatus"
    static let LoggedIn = "LoggedIn"
    static let LogOut = "LogOut"



    /// OTP page
    static let matchOTPLogin = baseURL + "auth/login/mobile"

    static let matchOTP = baseURL + "otps/validate"
    static let otp = "OTP"
    static let OTP = "otp"
    static let token = "token"
    
    /// User Register page
    static let usersRegister = baseURL + "users"
    static let Register = "Register"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let email = "email"
/// Login Page
    static let Login = "Login"
    static let getlogin = baseURL + "auth/generate-otp"
    
    /// Home Page
    static let getCategorycollections = baseURL + "collections"
    static let getsubcategoriescollections = baseURL + "sub-categories"
    static let getproducts = baseURL + "products"

    
    static let getcategories = baseURL + "categories"

    static let Home = "Home"
    static let Main = "Main"
    static let categoryId = "id"

    static let categoryName = "name"

    static let categorybanners = "banners"
    
    static let blankSpace = " "
    static let perTwenty = "%20"
    
    
    static let subcategoryId = "id"

    static let subcategoryName = "name"
    static let subdescription = "description"


    static let subcategorybanners = "banners"
    
    
    static let productid = "id"
    static let productname = "name"
    static let productprice = "price"
    static let productsellingPrice = "sellingPrice"
    static let productimages = "images"


    /// Product Details Page
    static let getProductDetails = baseURL + "products"
    
    static let getProductDetailscomments = baseURL + "comments"
    
    static let getusers = baseURL + "users"


    
    static let productDetailsId = "id"
    
    static let productDetailsname = "name"

    static let productDetailssku = "sku"

    static let productDetailsdescription = "description"

    static let productDetailsprice = "price"

    static let productDetailssellingPrice = "sellingPrice"

    

    static let comment = "comment"
    static let description = "description"
    static let userId = "userId"
    static let productId = "productId"


    

    
    
    //company api
    static let getCompanyList =  "company/"
    static let getStates = "states/"
    static let getCities = "cities/"
    //Group Api
    static let accountGroup = "accountGroup/"
    static let accountGroupAll = "accountGroup/all/"
    static let addSubAccountGroup = "subAccountGroup/"
    static let getAllSubAccounts = "subAccountGroup/all?company_id="
    static let stockGroup = "stockGroup/"
    static let getAllstockGroup = "stockGroup/all?company_id="
    static let subStockGroup = "substockGroup/"
    static let getAllSubStockGroup = "substockGroup/all?company_id="
   //Items
    static let getTaxes = "taxes/"
    static let getUnits = "units/"
    static let getAllItems = "item/all?company_id="
    static let items = "item/"
  //Ledger
    static let getAllLedger = "ledger/all?company_id="
    static let ledger =  "ledger/"
    //Vocuhers
    static let getSalePurchaseVoucher =  "ledger/getSalePurchaseVoucherLedger/"
    static let getAllLedgerWithoutBank =  "ledger/alllegerwithoutbak?company_id="
    //last date
    static let getLastDate = "saleVoucher/lastdate"
    static let getLastDateReceipt =  "recieptVoucher/lastdate"
    static let getLastDatePayment =  "paymentVoucher/lastdate"
    static let getLastDateDebit =  "debitVoucher/lastdate"
    static let getLastDateCredit =  "creditVoucher/lastdate"
    static let getLastDateJournalVoucher = "journalVoucher/lastdate"

  //  Direct Expence API :--
    static let getBankCaseLedger = "ledger/getbankcaseledger"
    static let getDirectExpenseLedger =  "ledger/getdiscountledger/"
    static let getDefaultBankLedger = "ledger/getBankdefault/"
    static let addSaleVoucher = "saleVoucher"
    static let addDebitVoucher = "debitVoucher"
    static let addCreditVoucher = "creditVoucher"
    static let getAllSaleVoucher = "saleVoucher/all"
    static let getAllPurchaseVoucher = "purchaseVoucher/all"
    static let addPurchaseVoucher = "purchaseVoucher"

  //forgot password
    static let forgotPassword =  "forgetpassword/otp"
    
    //get all receipts
   static let getAllReceiptVoucher =  "recieptVoucher/all"
   static let getAllPaymentVoucher =  "paymentVoucher/all"
   static let getAllDebitVoucher = "debitVoucher/all"
   static let getAllCreditVoucher = "creditVoucher/all"
   static let getAllJournalVoucher = "journalVoucher/all"

   static let receiptVoucher = "recieptVoucher/"
   static let paymentVoucher = "paymentVoucher/"
   static let journalVoucher = "journalVoucher/"


    //purpose
    static let creditPurpose =  "purpose/credit_note?company_id="
    static let debitPurpose =  "purpose/debit_note?company_id="
    static let journalPurpose =  "purpose/journal?company_id="


    static let creditLedger =  "ledger/getSalePurchaseLedger/"
    static let journalLedger = "ledger/getJournlVoucherLedger/"
   
    //Accounts Book
   static let getBankLedger =  "ledger/getbankledger"
   static let getCashLedger =  "ledger/getcashledger"
    

    
}
struct AppMessages {
    static let noInternetConnection = "No Internet Connection Available"
}
enum TextFieldDataSignup: Int {
    case nameTextField = 0
    case phoneTextField
    case emailTextField
    case passwordTextField
    case repeatPasswordTextField
}

enum TextFieldData: Int {
    
    case companyNameTextField = 10
    case stateTextField
    case cityTextField
    case bookStartDateTextField
    case gstTextField
    case companyPanTextField
    case areaTextField
    case streetTextField
    case pinCodeTextField
    case termsTextField

    
}

struct appConstants {
    static let loginToken = "Token"
    static let usernameKey = "username"
    static let userIDKey = "userId"
    static let mobileKey = "mobileno"
    static let emailKey = "email"
    static let subscriptionEndDateKey = "subscription_end_date"
    static let dateFormat = "dd-MMM-yyyy"
    static let dateFormatStartDate = "MM-dd-yyyy"
    static let dateFormatSubscription = "yyyy-MM-dd"

    static let dateFormatYear = "yyyy"
    static let dateFormatServer = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    
}
enum AlertMessages : String {
    case MessageTitle = "Alert"
    case Ok = "Ok"
    //sign up
    case AllFieldsMandatory = "All fields are mandatory"
    case EmailMandatory = "Please enter email or username"
    case PassowrdMandatory = "Please enter password"
    case PasswordDoesNotMatch = "Password does not match"
    case deleteCompany = "Are you sure you want to delete this company?"
    case deleteSubAccountGrp = "Are you sure you want to delete this sub account group?"
    case deleteStockGrp = "Are you sure you want to delete this stock group?"
    case deleteSubStockGrp = "Are you sure you want to delete this sub stock group?"
    case needPermissionMsg = "Please allow camera permissions from settings"
    case enterSubAccountName = "Please enter name"
    case enterSubAccountGroup = "Please select account group"
    case deleteItems = "Are you sure you want to delete this item?"
    case deleteLedger = "Are you sure you want to delete this ledger?"
    case companyMandatory = "Please enter company name"
    case stateMandatory = "Please select state"
    case cityMandatory = "Please select city"
    case bookStartMandatory = "Please enter financial year"

    case validEmailId = "Please enter valid email id"
    case validPhoneNumber = "Please enter valid phone number"
    case validPanNumber = "Please enter valid pan number"
    case validGstNumber = "Please enter valid GST number"
    case logoutAlert = "Are you sure you want to logout?"
    case enterCurrentPeriod = "Please enter current period date"
    case voucherLedgerSelect = "Please select ledger"
    case voucherAddress = "Please enter shipping address"
    case voucherShippingAddress = "Please enter address"
    case createSaleVoucher = "Are you sure you want to create this Sale Invoice?"
    case createPurchaseVoucher = "Are you sure you want to create this Purchase Invoice?"
    case createCreditVoucher = "Are you sure you want to create this Credit Note Invoice?"
    case createDebitVoucher = "Are you sure you want to create this Debit Note Invoice?"
    
    
    case createReceiptVoucher = "Are you sure you want to %@ this Receipt Invoice?"
    case createPaymentVoucher = "Are you sure you want to %@ this Payment Invoice?"
    case createJournalVoucher = "Are you sure you want to create this Journal Invoice?"
    case updateJournalVoucher = "Are you sure you want to update this Journal Invoice?"
    case purposeSelect = "Please select purpose"




    case bankcash = "Please select bank/cash"
    case amountCash = "Please enter amount"



}
enum AlertType {
    case BarCodeScan
    case DeleteCompany
    case DeleteAllRecord
    case RecordSaved
    case EditSiteNumber
    case AddNewItem
    case Retry
    case DateAlert
}

public var selectedCompanyName = ""
public var selectedCompanyUID = ""
public var currentPeriod = ""
public var currentPeriodStart = ""
public var currentPeriodEnd = ""
public var financialStart = ""
public var companyStateID = 0
public var bookStartDate = ""
public var currentStartYear = ""
public var currentEndYear = ""



func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
func isValidGSTNumber(gstNumber: String) -> Bool {
    let GSTRegEx = "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"
    let gstPred = NSPredicate(format:"SELF MATCHES %@", GSTRegEx)
    return gstPred.evaluate(with: gstNumber)
}
func isValidPanNumber(panNumber: String) -> Bool {
    let panRegEx = "^([A-Za-z]{5})([0-9]{4})([A-Za-z]{1})$"
    let panPred = NSPredicate(format:"SELF MATCHES %@", panRegEx)
    return panPred.evaluate(with: panNumber)
}
func isValidPhoneNumber(phoneNumber: String) -> Bool {
    let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
    let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
    return phonePred.evaluate(with: phoneNumber)
}

func showDashboard(){
    // ...
    // after login is done, maybe put this in the login web service completion block

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
    
    // This is to get the SceneDelegate object from your view controller
    // then call the change root view controller function to change to main tab bar
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    
}


