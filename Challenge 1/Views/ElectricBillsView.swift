//
//  ElectricBillsView.swift
//  Challenge 1
//
//  Created by Monica Dewi Seba on 20/03/25.

import SwiftUI

struct ElectricBillsView: View {
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
    
    @FocusState private var focusedField: Field?
    
    private func dismissKeyboard() {
        focusedField = nil
    }
    
    private func isDataSet() -> Bool {
        userDefaultsManager.defaults.value (forKey: "tanggalAwal") != nil
        || userDefaultsManager.defaults.value (forKey: "meteranAwal") != nil
        || userDefaultsManager.defaults.value (forKey: "meteranSaatIni") != nil
        || userDefaultsManager.defaults.value (forKey: "budget") != nil
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
    
    private func isOverBudget() -> Bool {
        return userDefaultsManager.estimasiPemakaian <= 0
    }
    
    private func isNearBudget() -> Bool {
        return userDefaultsManager.sisaKwh < 5 && userDefaultsManager.sisaKwh > 0
    }
    
    @Namespace var topID
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 20) {
                        if isDataSet() {
                            VStack(spacing: 12) {
                                Text("Tagihan Listrik")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.font)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                Text("per \(userDefaultsManager.tanggalAwal.formattedDate()) - \(userDefaultsManager.tanggalSaatIni.formattedDate())")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.font)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                Text("Rp \(userDefaultsManager.totalTagihanBerjalan)")
                                    .font(.system(size: 45, weight: .bold))
                                    .foregroundColor(.biru)
                                
                                Text("* Sudah termasuk Abonemen dan Pajak").font(.caption).foregroundStyle(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.color)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                            .id(topID)
                            
                            HStack(spacing: 16) {
                                StatCard(title: "Budget dalam kWh", value: "\(userDefaultsManager.convertBudgetToKwh) kWh", icon: "bolt.circle", isOverBudget: isOverBudget(), isNearBudget: isNearBudget())
                                StatCard(title: "Pemakaian per Hari", value: "\(userDefaultsManager.averageUsage) kWh", icon: "bolt.circle", isOverBudget: isOverBudget(), isNearBudget: isNearBudget())
                            }
                            .padding(.horizontal)
                            
                            if isOverBudget() {
                                if isNearBudget() {
                                    HStack {
                                        Image(systemName: "bolt.trianglebadge.exclamationmark")
                                            .foregroundColor(.notif3)
                                            .font(.system(size: 25))
                                        
                                        Text("Pemakaian listrik anda __hampir melewati budget__ dengan sisa __\(userDefaultsManager.sisaKwh) kWh__ ")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.notif3)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.bgnotif3)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal)
                                    
                                } else {
                                    HStack {
                                        Image(systemName: "bolt.trianglebadge.exclamationmark")
                                            .foregroundColor(.notif2).font(.system(size: 25))
                                        
                                        Text("Pemakaian listrik anda __sudah melewati budget__ yang ditentukan")
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
                            }
                            
                            else {
                                VStack {
                                    HStack {
                                        Image(systemName: "bolt.trianglebadge.exclamationmark")
                                            .foregroundColor(.notif1).font(.system(size: 25))
                                        
                                        Text("Dengan sisa __\(userDefaultsManager.sisaKwh) kWh__, Anda dapat menggunakan listrik selama __\(userDefaultsManager.estimasiPemakaian) Hari__")
                                            .font(.system(size: 16))
                                            .foregroundStyle(.notif1)
                                    }
                                    .padding(.bottom, 4)
                                    
                                    HStack {
                                        //                                        Spacer()
                                        
//                                        Text("* Berdasarkan rata-rata pemakaian listrik Anda")
//                                            .font(.caption)
//                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.bgnotif1)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                .padding(.horizontal)
                            }
                        }
                        
                        
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
                                           displayedComponents: .date
                                )
                                .labelsHidden()
                                
                                //                                    TextField("Masukkan Tanggal Meteran Awal", text: $tanggalAwal)
                                //                                        .textFieldStyle(.roundedBorder)
                                //                                        .focused($focusedField, equals: .tanggalAwal)
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
                                    TextField("Masukkan Budget per Unit", text: $budget)
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.decimalPad)
                                        .focused($focusedField, equals: .budget)
                                }
                                
                                Text("Minimal Rp 67.000/bulan").font(.caption).foregroundStyle(.secondary)
                            }
                            
                            Button {
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
                                
                                withAnimation {
                                    proxy.scrollTo(topID)
                                }
                                
                                if meteranAwal.isEmpty {
                                    focusedField = .meteranAwal
                                } else if meteranSaatIni.isEmpty {
                                    focusedField = .meteranSaatIni
                                } else if budget.isEmpty {
                                    focusedField = .budget
                                }
                                
                                dismissKeyboard()
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
                    .onTapGesture {
                        dismissKeyboard()
                    }
                    .onAppear {
                        if isDataSet() {
                            tanggalAwal = userDefaultsManager.tanggalAwal
                            meteranAwal = String(userDefaultsManager.meteranAwal)
                            meteranSaatIni = String(userDefaultsManager.meteranSaatIni)
                            budget = String(userDefaultsManager.budget)
                        }
                    }
                }
            }
        }
    }
    
    struct StatCard: View {
        var title: String
        var value: String
        var icon: String
        var isOverBudget: Bool
        var isNearBudget: Bool
        
        var body: some View {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 14))
                
                    .foregroundColor(.font)
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(isOverBudget ? (isNearBudget ? .notif3 : .notif2) : .notif1)
                        .font(.system(size: 25))
                    Text(value)
                        .font(.custom("SF Pro Rounded", size: 25).weight(.bold))
                        .foregroundColor(isOverBudget ? (isNearBudget ? .notif3 : .notif2) : .notif1)
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
