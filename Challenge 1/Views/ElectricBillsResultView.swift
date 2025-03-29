//
//  ElectricBillsView.swift
//  Challenge 1
//
//  Created by Monica Dewi Seba on 20/03/25.

import SwiftUI

struct ElectricBillsResultView: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    private func isNearBudget() -> Bool {
        return userDefaultsManager.estimasiPemakaian <= 3 && userDefaultsManager.estimasiPemakaian > 0
    }
    
    private func isOverBudget() -> Bool {
        return userDefaultsManager.estimasiPemakaian <= 0
    }
    
    @Namespace var topID
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 12) {
                            Text("Tagihan Listrik")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.font)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("\(userDefaultsManager.tanggalAwal.formattedDate()) - \(userDefaultsManager.tanggalSaatIni.formattedDate())")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.font)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Rp \(userDefaultsManager.totalTagihanBerjalan)")
                                .font(.system(size: 45, weight: .bold))
                                .foregroundColor(.biru)
                            
                            Text("* Sudah termasuk Abonemen dan Pajak").font(.caption2).foregroundStyle(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.color)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                        .id(topID)
                        
                        HStack(spacing: 16) {
                            StatCard(
                                title: "Budget dalam kWh",
                                value: "\(userDefaultsManager.convertBudgetToKwh) kWh",
                                icon: "bolt.circle",
                                isNearBudget: isNearBudget(),
                                isOverBudget: isOverBudget()
                            )
                            StatCard(
                                title: "Pemakaian Harian",
                                value: "\(userDefaultsManager.averageUsage) kWh",
                                icon: "bolt.circle",
                                isNearBudget: isNearBudget(),
                                isOverBudget: isOverBudget()
                            )
                        }
                        .padding(.horizontal)
                        
                        if isNearBudget() {
                            HStack {
                                Image(systemName: "bolt.trianglebadge.exclamationmark")
                                    .foregroundColor(.notif3)
                                    .font(.system(size: 25))
                                
                                Text("Pemakaian listrik Anda __akan mencapai budget__ dalam waktu __\(userDefaultsManager.estimasiPemakaian) hari__ ")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.notif3)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.bgnotif3)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        } else if isOverBudget() {
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
                            
                        } else {
                            VStack {
                                HStack {
                                    Image(systemName: "bolt.trianglebadge.exclamationmark")
                                        .foregroundColor(.notif1).font(.system(size: 25))
                                    
                                    Text("Dengan sisa __\(userDefaultsManager.sisaKwh) kWh__, Anda dapat menggunakan listrik selama __\(userDefaultsManager.estimasiPemakaian) Hari__")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.notif1)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.bgnotif1)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                        
                        
                        NavigationLink {
                            ElectricBillsCalculatorView()
                        } label: {
                            Text("Hitung Ulang")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color("Biru"))
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                .padding(.horizontal)
                        }
                    }
                    .padding()
                    
                    .navigationTitle("Tagihan")
                }
                .background(Color(UIColor.systemGray6))
            }
        }
    }
    
    struct StatCard: View {
        var title: String
        var value: String
        var icon: String
        var isNearBudget: Bool
        var isOverBudget: Bool
        
        var body: some View {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 14))
                
                    .foregroundColor(.font)
                HStack {
                    if isNearBudget {
                        Image(systemName: icon)
                            .foregroundColor(.notif3)
                            .font(.system(size: 20))
                        Text(value)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.notif3)
                    } else if isOverBudget {
                        Image(systemName: icon)
                            .foregroundColor(.notif2)
                            .font(.system(size: 20))
                        Text(value)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.notif2)
                    } else {
                        Image(systemName: icon)
                            .foregroundColor(.notif1)
                            .font(.system(size: 20))
                        Text(value)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.notif1)
                    }
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
    ElectricBillsResultView()
        .environmentObject(userDefaultsManager)
}
