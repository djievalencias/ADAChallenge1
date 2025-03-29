//
//  ContentView.swift
//  Challenge 1
//
//  Created by Djie Valencia Santoso on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userDefaultsManager = UserDefaultsManager.shared
    
    var body: some View {
        if userDefaultsManager.isDataSet() {
            ElectricBillsResultView()
                .environmentObject(userDefaultsManager)
        } else {
            ElectricBillsCalculatorView()
                .environmentObject(userDefaultsManager)
        }
    }
}

#Preview {
    ContentView()
}
