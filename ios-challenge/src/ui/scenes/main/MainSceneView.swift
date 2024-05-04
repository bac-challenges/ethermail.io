//
//  MainSceneView.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI

struct MainSceneView: View {
    var body: some View {
        DashboardView()
            .environmentObject(DashboardViewModel())
    }
}

#Preview {
    MainSceneView()
}
