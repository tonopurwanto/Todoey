//
//  Category.swift
//  Todoey
//
//  Created by Tono Purwanto on 29/01/18.
//  Copyright © 2018 Tono Purwanto. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let todos = List<Todo>()
}
