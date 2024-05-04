//
//  HistorySheet.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct HistorySheet: View {
    
    @EnvironmentObject
    private var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationStack {
            List {
                
                // Total
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Total Amount")
                            .font(.footnote)
                        Text("\(viewModel.totalAmount)")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
                
                // Transactions
                Section {
                    ForEach(viewModel.transactions, id:\.self) { item in
                        HistoryRow(item: item)
                    }
                }
            }
            .listSectionSpacing(40)
            .toolbarTitleDisplayMode(.inline)
            .toolbar(content: toolbar)
        }
        .presentationDragIndicator(.visible)
    }
    
    private func toolbar() -> some View {
        Button(action: viewModel.showHistory){
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    viewModel.store = MockStore()
    
    return HistorySheet().environmentObject(viewModel)
}

