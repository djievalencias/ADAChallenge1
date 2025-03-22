//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Monica Dewi Seba on 20/03/25.
import SwiftUI

struct ElectricBillsResult: View {
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Electric Bills")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            if(userDefaultsManager.estimasiPemakaian <= 0){
                HStack {
                Image(systemName: "bolt.trianglebadge.exclamationmark")
                    .foregroundColor(.notif2)
                    
                Text("Pemakaian Listrik anda sudah melewati budget yang ditentukan.")
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
                HStack {
                    Image(systemName: "bolt.trianglebadge.exclamationmark")
                        .foregroundColor(.notif1)
                    
                    Text("Dengan sisa \(userDefaultsManager.sisaKwh) kWh, anda dapat menggunakan listrik selama \(userDefaultsManager.estimasiPemakaian) Hari")
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
            
            VStack(spacing: 12) {
                HStack {
                    Text("      Tagihan Listrik Berjalan")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.font)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    //ZStack {
                      //  Circle()
                        //    .fill(Color.orange.opacity(0.2))
                          //  .frame(width: 24, height: 24)
                        
                        Image(systemName: "chevron.forward.circle")
                            .foregroundColor(.orange)
                            .font(.system(size: 18, weight: .bold))
                    }
              //  }
                    Text("Rp \(userDefaultsManager.totalTagihanBerjalan)")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.biru)
                        .padding(.vertical)
                    
                    VStack(spacing: 18) {
                        InfoRow(label: "Jumlah Penghuni", value: "\(userDefaultsManager.jumlahPenghuni) Orang")
                        InfoRow(label: "Meteran Awal", value: "\(userDefaultsManager.meteranAwal) kWh")
                        InfoRow(label: "Meteran Saat Ini", value: "\(userDefaultsManager.meteranSaatIni) kWh")
                        InfoRow(label: "Budget", value: "Rp. \(userDefaultsManager.budget)")
                    }
                    .padding(.top, 30)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.color)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                
                HStack(spacing: 16) {
                    StatCard(title: "Batas kWh", value: "\(userDefaultsManager.convertBudgetToKwh)", icon: "bolt.circle")
                    StatCard(title: "Total kWh Terpakai", value: "\(userDefaultsManager.consume)", icon: "bolt.circle")
                }
                .padding(.horizontal)
                
                // Footnote
                Text("Berdasarkan survey, rata-rata pemakaian di rusun menghabiskan 10 kWh / Hari")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 10)
            .background(Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    struct InfoRow: View {
        var label: String
        var value: String
        
        var body: some View {
            HStack {
                Text(label)
                    .font(.system(size: 16))
                    .foregroundColor(.font)
                Spacer()
                Text(value)
                    .font(.system(size: 16))
                    .foregroundColor(.font2)
            }
        }
    }
    

    struct StatCard: View {
        var title: String
        var value: String
        var icon: String
        
        var body: some View {
            VStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.font)
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.jingga)
                    Text(value)
                        .font(.custom("SF Pro Rounded", size: 25))
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.color)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
    
    struct ElectricBillsResult_Previews: PreviewProvider {
        static var previews: some View {
            let userDefaultsManager = UserDefaultsManager()
            ElectricBillsResult()
                .environmentObject(userDefaultsManager)
        }
    }

