//
//  HomeViewModel.swift
//  ElectricNorth
//
//  Created by Muhammad Bilal on 11/11/21.
//


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol HomeViewModelDelegate {
    func onSuccess(with message: String)
    func onFailure(with error: String)
}

class HomeViewModel: NSObject {
    var delegate: HomeViewModelDelegate?
    var viewController: BaseViewController!
    var newsModel = [NewsModel]()
    var sliderModel = [SliderImageModel]()

    var totalNewsModel: Int {
        return newsModel.count
    }
    
    var totalSliderModel: Int {
        return sliderModel.count
    }

    
    func news(at index: Int) -> NewsModel {
        return newsModel[index]
    }
    
    init(delegate: HomeViewModelDelegate, viewController: BaseViewController){
        self.delegate = delegate
        self.viewController = viewController
    }
}

//firebase calls handlings
extension HomeViewModel {
    func getHomeData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("LastNews").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let newsDict = snap.value as? String {
                        if !snap.key.contains("txt"){
                            let key = snap.key
                            print(key)
                            //                        print(newsDict[key])
                            let slider = SliderImageModel(image: "\(newsDict)")
                            self.sliderModel.append(slider)
                        }

                    } else {
                        print("Zhenya: failed to convert")
                    }
                }
                self.delegate?.onSuccess(with: "banners")
            }
        })
        
        ref.child("News").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("Zhenya: here is the snap: \(snap)")
                    if let newsDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let new = NewsModel(title: "\(newsDict["title"]!)", photoTitle: "\(newsDict["phototitle"]!)", publishdate: "\(newsDict["publishdate"]!)", onephopar: "\(newsDict["onephopar"]!)", twophopar: "\(newsDict["twophopar"]!)",onepar: "\(newsDict["onepar"]!)",twopar: "\(newsDict["twopar"]!)",threepar: "\(newsDict["threepar"]!)")
                        self.newsModel.append(new)
                    } else {
                        print("Zhenya: failed to convert")
                    }
                }
                self.newsModel = self.newsModel.reversed()
                self.delegate?.onSuccess(with: "")
            }
        })
        
    }
}
