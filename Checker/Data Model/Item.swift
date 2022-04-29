//
//  Item.swift
//  Checker
//
//  Created by Nicholas Els on 2022/04/28.
//

import Foundation
import RealmSwift
import Realm

class Item: Object {
 @objc dynamic  var title : String = ""
 @objc dynamic  var done : Bool = false
    @objc dynamic var dateMade : Date? 
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
