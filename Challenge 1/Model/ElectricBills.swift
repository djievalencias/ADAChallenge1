//
//  ElectricBills.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 18/03/25.
//

import Foundation
import SwiftUI

struct ElectricBills: Hashable, Codable {
    var jumlahPenghuni: Int
    var meteranAwal: Double
    var meteranSaatIni: Double
    var budget: Int
    
    init(_ jumlahPenghuni: Int, _ meteranAwal: Double, _ meteranSaatIni: Double, _ budget: Int) {
        self.jumlahPenghuni = jumlahPenghuni
        self.meteranAwal = meteranAwal
        self.meteranSaatIni = meteranSaatIni
        self.budget = budget
    }
    
    var demandCharge:Double = 1.3 * 47510 * 1.08
    
    var consume: Double {
        meteranSaatIni - meteranAwal
    }

    var pju: Double {
        consume * 1262 * 8 / 100
    }
    
    var totalTagihanBerjalan: Int {
        let doubleTotalTagihanBerjalan:Double = (demandCharge + consume * 1262 + pju) / Double(jumlahPenghuni)
        return Int(doubleTotalTagihanBerjalan.rounded())
    }
    
    var convertBudgetToKwh: Int {
        let doubleBudgetToKwh:Double = (Double(budget) - demandCharge) / (1262 * 1.08)
        return Int(doubleBudgetToKwh.rounded())
    }
    
    var sisaKwh: Int {
        let doubleSisaKwh:Double = Double(convertBudgetToKwh) - consume
        return Int(doubleSisaKwh.rounded())
    }
    
    var estimasiPemakaian: Int {
        return sisaKwh / 10
    }
}
