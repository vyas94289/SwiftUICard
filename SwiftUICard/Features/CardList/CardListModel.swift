//
//  CardListModel.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation
import Combine

class CardListModel: ObservableObject {
    
    @Published private(set) var state: State = .idle
    @Published var cardList: [CardInfo] = []
    private let input = PassthroughSubject<Event, Never>()
    
    func send(event: Event) {
        input.send(event)
        switch event {
        case .onAppear:
            self.getCardList()
        default:
            break
        }
    }
    
    func deleteCard(id: Int) {
        do {
            try DBManager.shared.deleteCard(id: id)
            self.getCardList()
        } catch {
            print(error)
        }
    }
}

extension CardListModel {
    enum State {
        case idle
        case loaded([CardInfo])
        case error(String)
        case noRecords
    }
    
    enum Event {
        case onAppear
        case onSelectThread(CardInfo)
        case onLoaded([CardInfo])
        case onFailedToLoad(String)
    }

    
    func getCardList() {
        do {
            self.cardList = try DBManager.shared.fetchAllCards()
            if self.cardList.isEmpty {
                self.state = .noRecords
            } else {
                self.state = .loaded(self.cardList)
            }
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
    
}
