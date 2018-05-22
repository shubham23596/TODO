//
//  Category.swift
//  TODO
//
//  Created by shubham jain on 17/05/18.
//  Copyright © 2018 shubham jain. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
