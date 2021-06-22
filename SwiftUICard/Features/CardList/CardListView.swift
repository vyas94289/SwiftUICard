//
//  CardListView.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 29/01/21.
//

import SwiftUI
import Neumorphic

struct CardListView: View {
    @StateObject var viewModel = CardListModel()
    @State var showAddCard: Bool = false
    var body: some View {
        NavigationView {
            content
                .onAppear{
                    viewModel.send(event: .onAppear)
                }
                .navigationTitle(Text("CardList"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .sheet(isPresented: $showAddCard, content: { CardDetailsView() {
                    viewModel.send(event: .onAppear)
                }})
                .navigationBarItems(trailing: Button("Add", action: {
                    self.showAddCard = true
                }).softButtonStyle(Capsule()))
                .background(Neumorphic.shared.mainColor().ignoresSafeArea(.all))
        }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.black.eraseToAnyView()
        case .error(let error):
            return NoRecordView(type: .error, title: "We're Sorry!", message: error).eraseToAnyView()
        case .loaded(let cards):
            return list(of: cards).eraseToAnyView()
        case .noRecords:
            return NoRecordView(type: .noRecord, title: "No Cards Found!", message: "Look like there're no card saved, kindly add new card").eraseToAnyView()
        }
    }
    
    private func list(of cards: [CardInfo]) -> some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(cards) { card in
                    CardView(card: card).contextMenu{
                        Button(action: {
                            viewModel.deleteCard(id: card.cardId ?? 0)
                    }) {
                        HStack {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        HStack {
                            Text("Edit")
                            Image(systemName: "pencil")
                        }
                    }
                    }
                }
            }.padding(.vertical, 20)
        }
    }
}
