//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Mustafa Kemal ARDA on 16.11.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView {
            
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                VStack(alignment: .leading) {
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                    Text(crypto.price)
                        .foregroundColor(.black)
                }
            }
            .toolbar(content: {
                Button {
                    Task.init {
                       // cryptoListViewModel.cryptoList = []
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    Text("Refresh")
                }

            })
            
            .navigationTitle(Text("Crypto Crazy"))
        }
        
        .task {
            
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            // await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        /*
        .onAppear {
            
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
         */
    }
}

#Preview {
    MainView()
}
