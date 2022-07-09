//  ConvertionView.swift
//  ExchangeAppSwiftUI
//  Created by Doston Rustamov on 08/07/22.

import SwiftUI

struct ConvertionView: View {
    
    @State private var inAmount: String = ""
    @State private var inputCurrency = "RUB" // Default currency
    @State private var outputCurrency = "RUB" // Default currency
    
    @FocusState private var isAmountFocused: Bool
    
    @StateObject private var viewModel = ConvertionViewModel()
    
    let currencies = ["RUB", "USD", "EUR", "GBR", "CHF", "CNY"]

    var body: some View {
        
        ZStack {
        
            VStack {
                
                VStack {
                    
                    TextField("0", text: $inAmount)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .padding()
                        .keyboardType(.numberPad)
                        .focused($isAmountFocused)
                    
                    Picker("Choose currecy", selection: $inputCurrency) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .tint(.gray)
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height/2
                )
                
                
                ZStack {
                    VStack {
                        
                        Text(viewModel.amount)
                            .padding()
                            .font(.largeTitle)
                        
                        Picker("Choose currecy", selection: $outputCurrency) {
                            ForEach(currencies, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.gray)
                        
                        Text ("Rate: \(viewModel.rate)")
                            .foregroundColor(.gray)
                        
                    }
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height/2
                    )
                    .background(.gray.opacity(0.1))
                }
                
            }
            
            Button {
                DispatchQueue.global().async {
                    self.viewModel.convertCurrency(from: self.inputCurrency, to: self.outputCurrency, amount: Float(self.inAmount) ?? 0)
                }
            } label: {
                Text("Convert")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.top, 50)
        .onTapGesture {
            isAmountFocused.toggle()
        }
        
    }
}

struct ConvertionView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertionView()
    }
}
