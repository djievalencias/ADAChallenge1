//
//  UserDefaults.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 20/03/25.
//

import Foundation
import Combine

final class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
    
    let defaults = UserDefaults.standard
    
    private enum Keys {
        static let tanggalAwal = "tanggalAwal"
        static let tanggalSaatIni = "tanggalSaatIni"
        static let meteranAwal = "meteranAwal"
        static let meteranSaatIni = "meteranSaatIni"
        static let budget = "budget"
        static let consume = "consume"
        static let averageUsage = "averageUsage"
        static let totalTagihanBerjalan = "totalTagihansBerjalan"
        static let convertBudgetToKwh = "convertBudgetToKwh"
        static let sisaKwh = "sisaKwh"
        static let estimasiPemakaian = "estimasiPemakaian"
    }
    
    init() {
        if let storedTanggalAwal = defaults.object(forKey: Keys.tanggalAwal) as? Date {
            tanggalAwal = storedTanggalAwal
        } else {
            tanggalAwal = Date()
        }
        if let storedTanggalSaatIni = defaults.object(forKey: Keys.tanggalSaatIni) as? Date {
            tanggalSaatIni = storedTanggalSaatIni
        } else {
            tanggalSaatIni = Date()
        }
        meteranAwal = defaults.double(forKey: Keys.meteranAwal)
        meteranSaatIni = defaults.double(forKey: Keys.meteranSaatIni)
        budget = defaults.integer(forKey: Keys.budget)
        consume = defaults.integer(forKey: Keys.consume)
        averageUsage = defaults.integer(forKey: Keys.averageUsage)
        totalTagihanBerjalan = defaults.integer(forKey: Keys.totalTagihanBerjalan)
        convertBudgetToKwh = defaults.integer(forKey: Keys.convertBudgetToKwh)
        estimasiPemakaian = defaults.integer(forKey: Keys.estimasiPemakaian)
        sisaKwh = defaults.integer(forKey: Keys.sisaKwh)
    }
    
    @Published var tanggalAwal: Date {
        didSet {
            defaults.set(tanggalAwal, forKey: Keys.tanggalAwal)
        }
    }
    
    @Published var tanggalSaatIni: Date {
        didSet {
            defaults.set(tanggalSaatIni, forKey: Keys.tanggalSaatIni)
        }
    }
    
    @Published var meteranAwal: Double {
        didSet {
            defaults.set(meteranAwal, forKey: Keys.meteranAwal)
        }
    }
    
    @Published var meteranSaatIni: Double {
        didSet {
            defaults.set(meteranSaatIni, forKey: Keys.meteranSaatIni)
        }
    }
    
    @Published var budget: Int {
        didSet {
            defaults.set(budget, forKey: Keys.budget)
        }
    }
    
    @Published var consume: Int {
        didSet {
            defaults.set(consume, forKey: Keys.consume)
        }
    }
    
    @Published var averageUsage: Int {
        didSet {
            defaults.set(averageUsage, forKey: Keys.averageUsage)
        }
    }
    
    @Published var totalTagihanBerjalan: Int {
        didSet {
            defaults.set(totalTagihanBerjalan, forKey: Keys.totalTagihanBerjalan)
        }
    }
    
    @Published var convertBudgetToKwh: Int {
        didSet {
            defaults.set(convertBudgetToKwh, forKey: Keys.convertBudgetToKwh)
        }
    }
    
    @Published var estimasiPemakaian: Int {
        didSet {
            defaults.set(estimasiPemakaian, forKey: Keys.estimasiPemakaian)
        }
    }
    
    @Published var sisaKwh: Int {
        didSet {
            defaults.set(sisaKwh, forKey: Keys.sisaKwh)
        }
    }
    
    func isDataSet() -> Bool {
        defaults.value (forKey: "tanggalAwal") != nil
        || defaults.value (forKey: "meteranAwal") != nil
        || defaults.value (forKey: "meteranSaatIni") != nil
        || defaults.value (forKey: "budget") != nil
    }
}
