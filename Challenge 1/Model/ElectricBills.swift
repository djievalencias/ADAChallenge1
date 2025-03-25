//
//  ElectricBills.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 18/03/25.
//

import Foundation
import SwiftUI

struct ElectricBills: Hashable, Codable {
    var meteranAwal: Double
    var meteranSaatIni: Double
    var budget: Int
    
    init(_ meteranAwal: Double, _ meteranSaatIni: Double, _ budget: Int) {
        self.meteranAwal = meteranAwal
        self.meteranSaatIni = meteranSaatIni
        self.budget = budget
    }
    
    var demandCharge:Double = 1.3 * 47510 * 1.08
    
    var consume: Int {
        let doubleConsume:Double = meteranSaatIni - meteranAwal
        return Int(doubleConsume.rounded())
    }

    var pju: Double {
        Double(consume) * 1262 * 8 / 100
    }
    
    var totalTagihanBerjalan: Int {
        let doubleTotalTagihanBerjalan:Double = (demandCharge + Double(consume) * 1262 + pju)
        return Int(doubleTotalTagihanBerjalan.rounded())
    }
    
    var convertBudgetToKwh: Int {
        let doubleBudgetToKwh:Double = (Double(budget) - demandCharge) / (1262 * 1.08)
        return Int(doubleBudgetToKwh.rounded())
    }
    
    var sisaKwh: Int {
        return convertBudgetToKwh - consume
    }
    
    var estimasiPemakaian: Int {
        let doubleEstimasiPemakaian:Double = Double(sisaKwh) / 10
        return Int(doubleEstimasiPemakaian.rounded())
    }
}
