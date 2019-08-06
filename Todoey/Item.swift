//
//  Item.swift
//  Todoey
//
//  Created by Isa  Selimi on 06/08/2019.
//  Copyright © 2019 com.isaselimi. All rights reserved.
//

import Foundation

class Item: Codable {
    
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
