//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 17/03/25.
//

import SwiftUI

struct ElectricBillsCalculator: View {
    @State var totalTagihanBerjalan: Int = 0
    @State var jumlahPenghuni: Int = 1
    @State var meteranAwal: Double = 0
    @State var meteranSaatIni: Double = 0
    @State var budget: Int = 0
    @State var budgetToKwh: Int = 0
    @State var totalKwhTerpakai: Int = 0
    @State var sisaKwh: Int = 0
    @State var estimasiPemakaian: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Total Tagihan Berjalan")
                    .font(.title)
                
                Text("Rp \(totalTagihanBerjalan)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("ShadedPink"))
                
                Text("Budget to kWh: \(budgetToKwh)")
                Text("Total kWh Terpakai: \(totalKwhTerpakai)")
                Text("Sisa kWh: \(sisaKwh)")
                Text("Estimasi pemakaian: sisa \(estimasiPemakaian) hari")
                
                Form {
                    VStack(alignment: .leading, spacing: 16) {
                        Section {
                            Label {
                                Text("Jumlah Penghuni")
                                    .foregroundColor(Color("ShadedRed"))
                            } icon: {
                                Image(systemName: "person.2")
                            }
                            .font(.title2)
                            .fontWeight(.semibold)
                            
                            Picker(
                                selection: $jumlahPenghuni,
                                label: Text("Jumlah Penghuni"))
                            {
                                /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                                /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        
                        Section {
                            Label {
                                Text("Meteran Awal (kWh)")
                                    .foregroundColor(Color("ShadedRed"))
                            } icon: {
                                Image(systemName: "bolt")
                            }
                            .font(.title2)
                            .fontWeight(.semibold)

                            TextField("Masukkan Meteran Awal dalam kWh", value: $meteranAwal, format: .number)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        
                        Section {
                            Label {
                                Text("Meteran Saat Ini (kWh)")
                                    .foregroundColor(Color("ShadedRed"))
                            } icon: {
                                Image(systemName: "bolt.fill")
                            }
                            .font(.title2)
                            .fontWeight(.semibold)
                           
                            TextField("Masukkan Meteran Saat Ini dalam kWh", value: $meteranSaatIni, format: .number)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        
                        Section {
                            Label {
                                Text("Budget")
                                    .foregroundColor(Color("ShadedRed"))
                            } icon: {
                                Image(systemName: "dollarsign.square")
                            }
                            .font(.title2)
                            .fontWeight(.semibold)
                            
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
                                Button("Hitung") {
                                    let electricBills = ElectricBills(
                                        jumlahPenghuni: jumlahPenghuni,
                                        meteranAwal: meteranAwal,
                                        meteranSaatIni: meteranSaatIni,
                                        budget: budget
                                    )
                                    
                                    totalTagihanBerjalan = electricBills.totalTagihanBerjalan
                                    totalKwhTerpakai = Int(electricBills.consume.rounded())
                                    budgetToKwh = electricBills.convertBudgetToKwh
                                    sisaKwh = electricBills.sisaKwh
                                    estimasiPemakaian = electricBills.estimasiPemakaian
                                }
                                .buttonStyle(.borderedProminent)
                                .font(.headline)
                                .disabled(meteranAwal <= 0
                                          || meteranSaatIni <= 0
                                          || budget <= 0
                                          || meteranAwal >= meteranSaatIni
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .tint(Color("ShadedPink"))
                
            }
            .navigationBarTitle("Electric Bills Calculator")
            .toolbar {
                Button("Reset") {
                    self.jumlahPenghuni = 1
                    self.meteranAwal = 0
                    self.meteranSaatIni = 0
                    self.budget = 0
                    self.totalTagihanBerjalan = 0
                }
                .foregroundColor(Color("ShadedPink"))
            }
        }
    }
}

#Preview {
    ElectricBillsCalculator()
}
