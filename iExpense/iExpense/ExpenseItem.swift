//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Aditya Narayan Swami on 02/12/21.
//

import Foundation
struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let date: Date
    let amount: Double
}
