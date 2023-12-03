//
//  Item.swift
//  SwiftDataExample
//
//  Created by Eugene Demenko on 03.12.2023.
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
