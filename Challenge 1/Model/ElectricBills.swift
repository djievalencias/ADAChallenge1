//
//  ElectricBills.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 18/03/25.
//

import Foundation
import SwiftUI

struct ElectricBills: Hashable, Codable {
    var tanggalAwal: Date
    var tanggalSaatIni: Date
    var meteranAwal: Double
    var meteranSaatIni: Double
    var budget: Int
    
    init(_ meteranAwal: Double, _ meteranSaatIni: Double, _ budget: Int, _ tanggalAwal: Date, _ tanggalSaatIni: Date) {
        self.meteranAwal = meteranAwal
        self.meteranSaatIni = meteranSaatIni
        self.budget = budget
        self.tanggalAwal = tanggalAwal
        self.tanggalSaatIni = tanggalSaatIni
    }
    
    var demandCharge:Double = 1.3 * 47510 * 1.08
    
    var consume: Int {
        let doubleConsume:Double = meteranSaatIni - meteranAwal
        return Int(doubleConsume.rounded())
    }
    
    var averageUsage: Int {
        let selisihHari = Calendar.current.dateComponents([.day], from: tanggalAwal, to: tanggalSaatIni)
        print("Selisih Hari: \(selisihHari.day ?? 0)")
        let doubleAverageUsage:Double = Double(consume) / Double(selisihHari.day ?? 1)
        print("Rata-rata Konsumsi Listrik per Hari: \(doubleAverageUsage)")
        return Int(doubleAverageUsage.rounded())
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
        let doubleEstimasiPemakaian:Double = Double(sisaKwh) / Double(averageUsage)
        return Int(doubleEstimasiPemakaian.rounded())
    }
}
