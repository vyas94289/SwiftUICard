//
//  CardDetailsView.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 29/01/21.
//

import SwiftUI
import Combine

struct CardDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = CardDetailsViewModel()
    @State var showsDatePicker = false
    var onDismiss = {}
    
    var body: some View {
        NavigationView {
            content
            .padding()
            .navigationBarTitle(Text("Card Details"), displayMode: .inline)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .navigationBarItems(trailing: saveButton)
        }
    }
    
    private var content: some View {
        
        VStack(spacing: 20) {
            
            Image(viewModel.cardNumberModel.cardIcon)
                .padding(.top, 20)
            
            CardFieldldView(title: "Holder Name",
                            placeholder: "Ex., Alex M Carry",
                            value: $viewModel.cardnameModel.data,
                            state: $viewModel.cardnameModel.state)
            
            CardFieldldView(title: "Card Number",
                            placeholder: "****************",
                            value: $viewModel.cardNumberModel.data,
                            state: $viewModel.cardNumberModel.state).keyboardType(.decimalPad)
            
            HStack(spacing: 20) {
                Button {
                    withAnimation {
                        showsDatePicker.toggle()
                    }
                } label: {
                    CardFieldldView(title: "Card Expiry",
                                    placeholder: "MM/YY",
                                    value: $viewModel.cardExpModel.dateString,
                                    state: $viewModel.cardExpModel.state).disabled(true)
                }
                CardFieldldView(title: "CVC",
                                placeholder: "***",
                                value: $viewModel.cardCVCModel.data,
                                state: $viewModel.cardCVCModel.state).keyboardType(.decimalPad)
                
            }
            
            if showsDatePicker {
                MonthYearPicker(selectedMonth: $viewModel.cardExpModel.selectedMonth, selectedYear: $viewModel.cardExpModel.selectedYear)
            }
        
            Spacer()
        }
    }
    
    private var saveButton: some View {
        Button("Save", action: {
            viewModel.saveCard()
            presentationMode.wrappedValue.dismiss()
            onDismiss()
        })
        .foregroundColor(viewModel.isValidCard ? Color.white : Color.gray)
        .disabled(!viewModel.isValidCard)
    }
}

struct CardFieldldView: View {
    var title: String
    var placeholder: String? = nil
    @Binding var value: String
    @Binding var state: TextFieldState
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.caption).padding(.leading, 15).foregroundColor(state.color)
            TextField(placeholder ?? title, text: $value)
                .modifier(PrimaryTextFieldStyle(state: $state))
        }
    }
}
