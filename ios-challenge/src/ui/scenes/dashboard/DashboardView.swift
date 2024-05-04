//
//  DashboardView.swift
//  ios-challenge
//
//  Created by emile on 04/05/2024.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject 
    private var viewModel: DashboardViewModel
    
    var body: some View {
        switch viewModel.loadingState {
        case .loading: ProgressView("Loading...")
                .task(viewModel.fetchCurrencies)
        case .loaded(let items): content(items)
        case .failed(let error): errorView(error)
        }
    }
    
    private func content(_ items: [Currency]) -> some View {
        NavigationStack {
            List(items, id:\.self) { item in
                CurrencyRow(item: item)
            }
            .navigationTitle("Dashboard")
            .refreshable(action: viewModel.fetchCurrencies)
            .toolbar(content: toolbar)
            .toolbarTitleDisplayMode(.inlineLarge)
            .sheet(isPresented: $viewModel.showingHistory, content: historySheet)
            .sheet(item: $viewModel.currency, content: currencyBuySheet)
        }
    }
    
    private func toolbar() -> some View {
        Button(action: viewModel.showHistory) {
            Image(systemName: "arrow.up.arrow.down")
        }
        .disabled(viewModel.isHistoryAvailable)
    }
    
    private func currencyBuySheet(item: Currency) -> CurrencyBuySheet {
        CurrencyBuySheet()
    }
    
    private func historySheet() -> HistorySheet {
        HistorySheet()
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "network.slash")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.secondary)
                
            Text("\(error.localizedDescription)")
                .multilineTextAlignment(.center)
            
            Button("Retry") {
                Task {
                    await viewModel.fetchCurrencies()
                }
            }
        }.padding(40)
    }
}

#Preview {
    let viewModel = DashboardViewModel()
    viewModel.store = MockStore()

    return DashboardView().environmentObject(viewModel)
}

