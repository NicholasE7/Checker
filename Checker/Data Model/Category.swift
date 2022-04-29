//
//  Category.swift
//  Checker
//
//  Created by Nicholas Els on 2022/04/28.
//

import Foundation
import Realm
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}


