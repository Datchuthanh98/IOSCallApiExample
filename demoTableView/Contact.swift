//
//  Contact.swift
//  demoTableView
//
//  Created by Chu Thanh Dat on 8/26/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import Foundation

struct DataList: Codable {
    var data : [Person]
}

struct Person: Codable {
    var userName: String
    var image: String
    var location : String
    var age : Int
    var gender : String
    
}

