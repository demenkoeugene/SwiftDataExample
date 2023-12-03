//
//  Expense.swift
//  SwiftDataExample
//
//  Created by Eugene Demenko on 03.12.2023.
//

import Foundation
import SwiftData

@Model
class Expense {
    @Attribute(.unique) var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
