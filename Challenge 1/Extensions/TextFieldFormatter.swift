//
//  TextFieldFormatter.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 25/03/25.
//

import Foundation

private let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.decimalSeparator = ","
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter
}()

func formatNumber(_ number: String) -> String {
       guard !number.isEmpty, let value = Double(number) else {
           return "0"
       }
       let formatter = numberFormatter
       let formattedString = formatter.string(from: NSNumber(value: value)) ?? "0"
       return formattedString
   }

