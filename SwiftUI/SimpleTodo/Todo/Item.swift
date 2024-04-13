//
//  Item.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
