//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Monica Dewi Seba on 20/03/25.

import SwiftUI

struct ElectricBillsView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    @State private var meteranAwal: String = ""
    @State private var meteranSaatIni: String = ""
    @State private var budget: String = ""
    
    private func isDataSet() -> Bool {
        userDefaultsManager.defaults.value (forKey: "meteranAwal") != nil
        || userDefaultsManager.defaults.value (forKey: "meteranSaatIni") != nil
        || userDefaultsManager.defaults.value (forKey: "budget") != nil
    }
    
    private func isDisabled() -> Bool {
        return meteranAwal.isEmpty || meteranSaatIni.isEmpty || budget.isEmpty
    }
    
    private func isOverBudget() -> Bool {
        return userDefaultsManager.estimasiPemakaian <= 0
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text("Tagihan Listrik Berjalan")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.font)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if isDataSet() {
                        Text("per \(userDefaultsManager.tanggal)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.font)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Text("Rp \(userDefaultsManager.totalTagihanBerjalan)")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.biru)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.color)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                
                HStack(spacing: 16) {
                    StatCard(title: "Batas kWh", value: "\(userDefaultsManager.convertBudgetToKwh)", icon: "bolt.circle", isOverBudget: isOverBudget())
                    StatCard(title: "Total kWh Terpakai", value: "\(userDefaultsManager.consume)", icon: "bolt.circle", isOverBudget: isOverBudget())
                }
                .padding(.horizontal)
                
                if isDataSet() {
                    if(isOverBudget()){
                        HStack {
                            Image(systemName: "bolt.trianglebadge.exclamationmark")
                                .foregroundColor(.notif2).font(.system(size: 20))
                            
                            Text("Pemakaian Listrik anda __sudah melewati budget__ yang ditentukan")
                                .font(.system(size: 16))
                                .foregroundStyle(.notif2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.bgnotif2)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    
                    else {
                        HStack {
                            Image(systemName: "bolt.trianglebadge.exclamationmark")
                                .foregroundColor(.notif1).font(.system(size: 20))
                            
                            Text("Dengan sisa __\(userDefaultsManager.sisaKwh) kWh__, Anda dapat menggunakan listrik selama __\(userDefaultsManager.estimasiPemakaian) Hari__, berdasarkan rata-rata pemakaian 10 kWh/hari di rusun")
                                .font(.system(size: 16))
                                .foregroundStyle(.notif1)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.bgnotif1)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }
                
                VStack(spacing: 16) {
                    Section {
                        HStack {
                            Text("Meteran Awal").fontWeight(.semibold)
                            
                            TextField("kWh", text: $meteranAwal)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Meteran Saat Ini").fontWeight(.semibold)
                            
                            TextField("kWh", text: $meteranSaatIni)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Budget per Unit").fontWeight(.semibold)
                            
                            TextField("Rp / bulan", text: $budget)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Button {
                        let electricBills = ElectricBills(
                            Double(meteranAwal) ?? 0.0,
                            Double(meteranSaatIni) ?? 0.0,
                            Int(budget) ?? 0
                        )
                        
                        userDefaultsManager.tanggal = Date.now.formattedDate()
                        userDefaultsManager.meteranAwal = Double(meteranAwal) ?? 0.0
                        userDefaultsManager.meteranSaatIni = Double(meteranSaatIni) ?? 0.0
                        userDefaultsManager.budget = Int(budget) ?? 0
                        
                        // Computed properties
                        userDefaultsManager.consume = electricBills.consume
                        userDefaultsManager.totalTagihanBerjalan = electricBills.totalTagihanBerjalan
                        userDefaultsManager.convertBudgetToKwh = electricBills.convertBudgetToKwh
                        userDefaultsManager.sisaKwh = electricBills.sisaKwh
                        if (electricBills.sisaKwh <= 10 && electricBills.sisaKwh > 0) {
                            userDefaultsManager.estimasiPemakaian = 1
                        } else {
                            userDefaultsManager.estimasiPemakaian = electricBills.estimasiPemakaian
                        }
                    } label: {
                        Text("Hitung")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .opacity(isDisabled() ? 0.5 : 1)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(isDisabled())
                    .background(Color("Biru"))
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.color)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                .navigationTitle("BilLis")
                
                Spacer()
            }
            .onAppear {
                if isDataSet() {
                    meteranAwal = String(userDefaultsManager.meteranAwal)
                    meteranSaatIni = String(userDefaultsManager.meteranSaatIni)
                    budget = String(userDefaultsManager.budget)
                }
            }
        }
    }
    
    struct StatCard: View {
        var title: String
        var value: String
        var icon: String
        var isOverBudget: Bool
        
        var body: some View {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.font)
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(isOverBudget ? .notif2 : .notif1)
                    Text(value)
                        .font(.custom("SF Pro Rounded", size: 25))
                        .foregroundColor(isOverBudget ? .notif2 : .notif1)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.color)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    let userDefaultsManager = UserDefaultsManager()
    ElectricBillsView()
        .environmentObject(userDefaultsManager)
}
