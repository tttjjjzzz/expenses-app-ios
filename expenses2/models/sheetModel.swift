//
//  sheetModel.swift
//  expenses2
//
//  Created by Tiger Zhou on 2024-12-28.
//

import Foundation

struct Sheet: Identifiable{
    
    var id: UUID
    var name: String
    var expenses: [Expense]
    
    init(name: String){
        self.id = UUID()
        self.name = name
        self.expenses = []
    }
    
    var sortedExpenses: [Expense]{
        expenses.sorted { $0.date > $1.date }
    }
    
    func totalAmount(type:String) -> Double{
        var total: Double = 0
        
        if type == "total"{
            for ind in expenses{
                total += ind.amount
            }
            
        }else{
            total = expenses.filter { $0.category == type }
                .reduce(0) { $0 + $1.amount }
            
        }
        return total
    }
    
    
    func monthAvg(type: String) -> Double {
       
        let total = totalAmount(type: type)
        let filteredExpenses = type == "total" ? expenses : expenses.filter { $0.category == type }
    
        guard let firstDate = filteredExpenses.min(by: { $0.date < $1.date })?.date,
              let lastDate = filteredExpenses.max(by: { $0.date < $1.date })?.date else {
            return 0
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: firstDate, to: lastDate)
        let totalDays = max(components.day ?? 0, 1) // Ensure totalDays is at least 1 to avoid division by zero
        
        if totalDays == 1 {
            return 0;
        }else{
            return (total / Double(totalDays)) * 30
        }
        
    }

    
    
}



