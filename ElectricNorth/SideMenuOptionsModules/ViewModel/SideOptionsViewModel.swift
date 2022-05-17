//
//  SideOptionsViewModel.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/12/21.
//


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import CodableFirebase

protocol SideOptionsViewModelDelegate {
    func onSuccess(with message: String)
    func onFailure(with error: String)
}

class SideOptionsViewModel: NSObject {
    var delegate: SideOptionsViewModelDelegate?
    var viewController: BaseViewController!
    var dataListing = [Any]()
    var organizaitionListing = [[String:AnyObject]]()

    
    var totalDataListings: Int {
        return dataListing.count
    }
    
    func data(at index: Int) -> Any {
        return dataListing[index]
    }
    
    init(delegate: SideOptionsViewModelDelegate, viewController: BaseViewController){
        self.delegate = delegate
        self.viewController = viewController
    }
}

//firebase calls handlings
extension SideOptionsViewModel {
    
    func getOperationListing(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Operations").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print(" here is the snap: \(snap)")
                    if let operationDict = snap.value as? Dictionary<String, AnyObject> {
                        self.dataListing.append(OperationListingModel(name: "\(operationDict["name"]!)", desc: "\(operationDict["desc"]!)", photo: "\(operationDict["photo"]!)"))
                        self.delegate?.onSuccess(with: "fetched successfully!")
                    } else {
                        print("Zhenya: failed to convert")
                        self.delegate?.onFailure(with: "Faild to convert data")
                    }
                }
            }
        })
    }
    
    func getVideoListing(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("OrgTv").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print(" here is the snap: \(snap)")
                    if let videoDict = snap.value as? Dictionary<String, AnyObject> {
                        print(videoDict)
                        self.dataListing.append(VideoListingModel(name: "\(videoDict["name"]!)", videoid: "\(videoDict["videoid"]!)"))
                    } else {
                        print("Zhenya: failed to convert")
                        self.delegate?.onFailure(with: "Faild to convert data")
                    }
                }
                self.delegate?.onSuccess(with: "fetched successfully!")
            }
        })
    }
    
    func getOrganizationListing(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Organizations").observeSingleEvent(of: .value, with: { (snapshot) in
//            do {
//                let model = try FirebaseDecoder().decode([OrganizationListingModel].self, from: snapshot.value)
//
//                self.dataListing = model
//            } catch let error {
//                print(error)
//            }
            
                        if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                            for snap in snapshot {
                                print(" here is the snap: \(snap)")
                                if let operationDict = snap.value as? Dictionary<String, AnyObject> {
                                    self.organizaitionListing.append(operationDict)
                                    self.delegate?.onSuccess(with: "fetched successfully!")
                                } else {
                                    print("Zhenya: failed to convert")
                                    self.delegate?.onFailure(with: "Faild to convert data")
                                }
                            }
                        }
        })
    }
    
    
}
