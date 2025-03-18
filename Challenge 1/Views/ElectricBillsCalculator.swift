//
//  ElectricBillsCalculator.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 17/03/25.
//

import SwiftUI

struct ElectricBillsCalculator: View {
    var body: some View {
        VStack {
            VStack {
                Text("Total Tagihan Berjalan")
                    .font(.title)
                    .padding(.bottom, 4)
                Text("Rp0")
                    .font(.largeTitle)
                    .padding(.bottom, 64)
                VStack(alignment: .leading) {
                    HStack {
                        Label("Jumlah Penghuni", systemImage: "person.2")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Jumlah Penghuni")) {
                            /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                            /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        }
                    }
                    
                    Label("Meteran Awal", systemImage: "bolt")
                        .font(.title2)
                        .fontWeight(.semibold)
                    TextField("Masukkan Meteran Awal", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(.roundedBorder)
                    
                    Label("Meteran Saat Ini", systemImage: "bolt.fill")
                        .font(.title2)
                        .fontWeight(.semibold)
                    TextField("Masukkan Meteran Saat Ini", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(.roundedBorder)
                    
                    Label("Budget", systemImage: "dollarsign.square")
                        .font(.title2)
                        .fontWeight(.semibold)
                    HStack {
                        Text("Rp").foregroundStyle(.secondary)
                        TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                            .textFieldStyle(.roundedBorder)
                        Text("/Bulan")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .fontWeight(.bold)
            .padding(.bottom, 64)
            
            Button("Hitung") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .buttonStyle(.borderedProminent)
            .font(.headline)
        }
        .padding()
       
    }
}

#Preview {
    ElectricBillsCalculator()
}
