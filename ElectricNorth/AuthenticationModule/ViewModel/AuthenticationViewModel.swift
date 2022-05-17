//
//  AuthenticationViewModel.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/3/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol AuthenticationViewModelDelegate {
    func onSuccess(with message: String)
    func onFailure(with error: String)
}

class AuthenticationViewModel: NSObject {
    var delegate: AuthenticationViewModelDelegate?
    var viewController: BaseViewController!
    
    init(delegate: AuthenticationViewModelDelegate, viewController: BaseViewController){
        self.delegate = delegate
        self.viewController = viewController
    }
}

//firebase calls handlings
extension AuthenticationViewModel {
    func alreadySignIn(){
        GCD.async(.Main) {
            self.viewController.startActivityWithMessage(msg: "")
        }
        if (Auth.auth().currentUser != nil){
            self.delegate?.onSuccess(with: "welcome")
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").getData { error, dataSnapshot in
                
                let name =  dataSnapshot.value as? [String: AnyObject]
                Global.shared.userModel.fullName = name?["Name"] as? String ?? "nil"
                
            }
            
        }
        GCD.async(.Main) {
            self.viewController.stopActivity()
        }
        self.delegate?.onFailure(with: "please login")
    }
    
    func verifyPhoneNumber(phoneNumber: String){
        GCD.async(.Main) {
            self.viewController.startActivityWithMessage(msg: "")
        }
        Auth.auth().languageCode = "en"
        
        // Step 4: Request SMS
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            GCD.async(.Main) {
                self.viewController.stopActivity()
            }
            if let error = error {
                print(error.localizedDescription)
                self.delegate?.onFailure(with: error.localizedDescription)
                return
            }
            
            // Either received APNs or user has passed the reCAPTCHA
            // Step 5: Verification ID is saved for later use for verifying OTP with phone number
            Global.shared.userModel.currentVerificationId = verificationID!
            self.delegate?.onSuccess(with: "Success")
            
        }
    }
    
    func verifyOtpCode() {
        GCD.async(.Main) {
            self.viewController.startActivityWithMessage(msg: "")
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: Global.shared.userModel.currentVerificationId, verificationCode: Global.shared.userModel.code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            GCD.async(.Main) {
                self.viewController.stopActivity()
            }
            if let error = error {
                let authError = error as NSError
                print(authError.description)
                self.delegate?.onFailure(with: error.localizedDescription)
                return
            }
            // User has signed in successfully and currentUser object is valid
            let currentUserInstance = Auth.auth().currentUser?.uid
            self.delegate?.onSuccess(with: "Code verified")
        }
    }
    
    func registerUserOnFirebase(name: String = ""){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        GCD.async(.Main) {
            self.viewController.startActivityWithMessage(msg: "")
        }
        var dataDictionary: [String: Any] = [:]
        dataDictionary["Name"] = name == "" ? Global.shared.userModel.fullName : name
        
        ref.child("Users").child(Auth.auth().currentUser?.uid ?? "").setValue(dataDictionary){
            (error:Error?, ref:DatabaseReference) in
            GCD.async(.Main) {
                self.viewController.stopActivity()
            }
            if let error = error {
                print("Data could not be saved: \(error).")
                self.delegate?.onFailure(with: error.localizedDescription)
            } else {
                print("Data saved successfully!")
                self.delegate?.onSuccess(with: "User register successfully")
            }
        }
        
    }
}
