//
//  UserListingModel.swift
//  ElectricNorth
//
//  Created by Zohaib on 20/11/2021.
//

import Foundation
import CodableFirebase

struct OrganizationListingModel:Codable{
    var name: String
    var list: [OrganizationListingModel]
}
