//
//  expense.swift
//  expenses2
//
//  Created by Tiger Zhou on 2024-12-28.
//

import Foundation

struct Expense: Identifiable{
    
    var id: UUID
    var date: Date
    var amount: Double
    var category: String
    var iconName: String
    
    init(date: Date, amount: Double, category: String, iconName: String) {
        self.id = UUID()
        self.date = date
        self.amount = amount
        self.category = category
        self.iconName = iconName
    }
}



