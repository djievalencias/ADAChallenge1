//
//  DateExtension.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 24/03/25.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self)
    }
}
