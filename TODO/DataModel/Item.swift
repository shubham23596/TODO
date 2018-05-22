//
//  Item.swift
//  TODO
//
//  Created by shubham jain on 17/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
