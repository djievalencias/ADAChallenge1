//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 17/03/25.
//

import SwiftUI

struct ElectricBillsCalculator: View {
    @State var jumlahPenghuni: Int = 1
    @State var meteranAwal: Double = 0
    @State var meteranSaatIni: Double = 0
    @State var budget: Int = 0
    
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 24) {
                    Section {
                        Label {
                            Text("Jumlah Penghuni")
                        } icon: {
                            Image(systemName: "person.2")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        Picker(
                            selection: $jumlahPenghuni,
                            label: Text("Jumlah Penghuni"))
                        {
                            /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                            /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Section {
                        Label {
                            Text("Meteran Awal (kWh)")
                        } icon: {
                            Image(systemName: "bolt")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))

                        TextField("Masukkan Meteran Awal dalam kWh", value: $meteranAwal, format: .number)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    
                    Section {
                        Label {
                            Text("Meteran Saat Ini (kWh)")
                        } icon: {
                            Image(systemName: "bolt.fill")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                       
                        TextField("Masukkan Meteran Saat Ini dalam kWh", value: $meteranSaatIni, format: .number)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    
                    Section {
                        Label {
                            Text("Budget per Unit")
                        } icon: {
                            Image(systemName: "dollarsign.square")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Biru"))
                        
                        HStack {
                            Text("Rp").foregroundStyle(.secondary)
                            TextField("", value: $budget, format: .number)
                                .textFieldStyle(.roundedBorder)
                            Text("/bulan")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    
                    Section {
                        HStack {
                            Button {
                                let electricBills = ElectricBills(
                                    jumlahPenghuni,
                                    meteranAwal,
                                    meteranSaatIni,
                                    budget
                                )
                                
                                userDefaultsManager.jumlahPenghuni = jumlahPenghuni
                                userDefaultsManager.meteranAwal = meteranAwal
                                userDefaultsManager.meteranSaatIni = meteranSaatIni
                                userDefaultsManager.budget = budget
                                
                                // Computed properties
                                userDefaultsManager.consume = electricBills.consume
                                userDefaultsManager.totalTagihanBerjalan = electricBills.totalTagihanBerjalan
                                userDefaultsManager.convertBudgetToKwh = electricBills.convertBudgetToKwh
                                userDefaultsManager.estimasiPemakaian = electricBills.estimasiPemakaian
                                userDefaultsManager.sisaKwh = electricBills.sisaKwh
                            } label: {
                                Text("Hitung")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 20)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("Biru"))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .padding()
//                            .disabled(meteranAwal <= 0
//                                      || meteranSaatIni <= 0
//                                      || budget <= 0
//                                      || meteranAwal >= meteranSaatIni
//                            )
                        }
                    }
                }
            }
            .navigationBarTitle("Hitung Tagihan Listrik")
            .toolbar {
                Button("Reset") {
                    self.jumlahPenghuni = 1
                    self.meteranAwal = 0
                    self.meteranSaatIni = 0
                    self.budget = 0
//                    self.totalTagihanBerjalan = 0
                }
                .foregroundColor(Color("Biru"))
            }
        }
        .onAppear {
            jumlahPenghuni = userDefaultsManager.jumlahPenghuni
            meteranAwal = userDefaultsManager.meteranAwal
            meteranSaatIni = userDefaultsManager.meteranSaatIni
            budget = userDefaultsManager.budget
        }
        .padding(.horizontal)
    }
}

#Preview {
    let userDefaultsManager = UserDefaultsManager()
    ElectricBillsCalculator()
        .environmentObject(userDefaultsManager)
}
