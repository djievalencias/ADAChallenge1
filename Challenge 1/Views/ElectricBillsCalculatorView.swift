//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 17/03/25.
//

import SwiftUI

struct ElectricBillsCalculatorView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    enum Field:Hashable {
        case meteranAwal
        case meteranSaatIni
        case budget
        case tanggalAwal
    }
    
    @State private var tanggalAwal: Date = Date()
    @State private var meteranAwal: String = ""
    @State private var meteranSaatIni: String = ""
    @State private var budget: String = ""
    
    @State private var navigateToResult = false
    
    @FocusState private var focusedField: Field?
    
    private func dismissKeyboard() {
        focusedField = nil
    }
    
    private func isDisabled() -> Bool {
        let calendar = Calendar.current
        
        return meteranAwal.isEmpty
        || meteranSaatIni.isEmpty
        || budget.isEmpty
        || Double(meteranAwal.replacingOccurrences(of: ",", with: ".")) ?? 0.0 <= 0
        || Double(meteranSaatIni.replacingOccurrences(of: ",", with: ".")) ?? 0.0 <= 0
        || Int(budget) ?? 0 <= 67000
        || Double(meteranAwal.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        >= Double(meteranSaatIni.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        || calendar.startOfDay(for: tanggalAwal) >= calendar.startOfDay(for: Date.now)
        
    }
    
    private func hitung() {
        let electricBills = ElectricBills(
            Double(meteranAwal.replacingOccurrences(of: ",", with: ".")) ?? 0.0,
            Double(meteranSaatIni.replacingOccurrences(of: ",", with: ".")) ?? 0.0,
            Int(budget) ?? 0,
            tanggalAwal,
            Date.now
        )
        
        userDefaultsManager.tanggalAwal = tanggalAwal
        userDefaultsManager.tanggalSaatIni = Date.now
        userDefaultsManager.meteranAwal = Double(meteranAwal) ?? 0.0
        userDefaultsManager.meteranSaatIni = Double(meteranSaatIni) ?? 0.0
        userDefaultsManager.budget = Int(budget) ?? 0
        
        // Computed properties
        userDefaultsManager.consume = electricBills.consume
        userDefaultsManager.totalTagihanBerjalan = electricBills.totalTagihanBerjalan
        userDefaultsManager.convertBudgetToKwh = electricBills.convertBudgetToKwh
        userDefaultsManager.sisaKwh = electricBills.sisaKwh
        userDefaultsManager.estimasiPemakaian = electricBills.estimasiPemakaian
        userDefaultsManager.averageUsage = electricBills.averageUsage
        
        
        if meteranAwal.isEmpty {
            focusedField = .meteranAwal
        } else if meteranSaatIni.isEmpty {
            focusedField = .meteranSaatIni
        } else if budget.isEmpty {
            focusedField = .budget
        }
        
        navigateToResult = true
    }
    
    @Namespace var topID
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Section {
                        Label {
                            Text("Tanggal Meteran Awal")
                        } icon: {
                            Image(systemName: "calendar")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        DatePicker("", selection: $tanggalAwal,
                                   in: Calendar.current.date(byAdding: .year, value: -1, to: Date())!...Date(),
                                   displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Section {
                        Label {
                            Text("Meteran Awal")
                        } icon: {
                            Image(systemName: "bolt")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        HStack {
                            TextField("Masukkan Meteran Awal", text: $meteranAwal)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .meteranAwal)
                            
                            Text("kWh")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    
                    Section {
                        Label {
                            Text("Meteran Saat Ini")
                        } icon: {
                            Image(systemName: "bolt.fill")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        HStack {
                            TextField("Masukkan Meteran Saat Ini", text: $meteranSaatIni)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .meteranSaatIni)
                            Text("kWh")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    
                    Section {
                        Label {
                            Text("Budget Tagihan Listrik")
                        } icon: {
                            Image(systemName: "dollarsign.square")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        HStack {
                            Text("Rp").foregroundStyle(.secondary)
                            TextField("Masukkan Budget Tagihan Listrik", text: $budget)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .budget)
                        }
                        
                        Text("Minimal Rp 67.000/bulan").font(.caption).foregroundStyle(.secondary)
                    }
                    
                    Button(action: {
                        hitung()
                    }) {
                        Text("Hitung")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .opacity(isDisabled() ? 0.5 : 1)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color("Biru"))
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                    }
                    .disabled(isDisabled())
                    .navigationDestination(isPresented: $navigateToResult) {
                        ElectricBillsResultView(showResultView: $navigateToResult)
                    }
                }
                .padding()
                .navigationTitle("Kalkulator")
                .toolbar {
                    Button("Reset") {
                        tanggalAwal = Date.now
                        meteranAwal = ""
                        meteranSaatIni = ""
                        budget = ""
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
        }
        
        .onTapGesture {
            dismissKeyboard()
        }
        
        .onAppear {
            if userDefaultsManager.isDataSet() {
                tanggalAwal = userDefaultsManager.tanggalAwal
                meteranAwal = String(userDefaultsManager.meteranAwal)
                meteranSaatIni = String(userDefaultsManager.meteranSaatIni)
                budget = String(userDefaultsManager.budget)
            }
        }
    }
}

//#Preview {
//    let userDefaultsManager = UserDefaultsManager()
//    ElectricBillsCalculatorView(isShowing: $isShowingCalculator)
//        .environmentObject(userDefaultsManager)
//}
