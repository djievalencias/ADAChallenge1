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
        static let tanggal = "tanggal"
        static let meteranAwal = "meteranAwal"
        static let meteranSaatIni = "meteranSaatIni"
        static let budget = "budget"
        static let consume = "consume"
        static let totalTagihanBerjalan = "totalTagihansBerjalan"
        static let convertBudgetToKwh = "convertBudgetToKwh"
        static let sisaKwh = "sisaKwh"
        static let estimasiPemakaian = "estimasiPemakaian"
    }
    
    init() {
        tanggal = defaults.string(forKey: Keys.tanggal) ?? ""
        meteranAwal = defaults.double(forKey: Keys.meteranAwal)
        meteranSaatIni = defaults.double(forKey: Keys.meteranSaatIni)
        budget = defaults.integer(forKey: Keys.budget)
        consume = defaults.integer(forKey: Keys.consume)
        totalTagihanBerjalan = defaults.integer(forKey: Keys.totalTagihanBerjalan)
        convertBudgetToKwh = defaults.integer(forKey: Keys.convertBudgetToKwh)
        estimasiPemakaian = defaults.integer(forKey: Keys.estimasiPemakaian)
        sisaKwh = defaults.integer(forKey: Keys.sisaKwh)
    }
    
    @Published var tanggal: String {
        didSet {
            defaults.set(tanggal, forKey: Keys.tanggal)
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
}
