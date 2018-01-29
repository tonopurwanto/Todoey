//
//  Todo.swift
//  Todoey
//
//  Created by Tono Purwanto on 29/01/18.
//  Copyright © 2018 Tono Purwanto. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "todos")
}
