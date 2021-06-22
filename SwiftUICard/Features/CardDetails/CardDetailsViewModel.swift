//
//  CardDetailsViewModel.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 29/01/21.
//

import Combine
import Foundation

class CardDetailsViewModel: ObservableObject {
    @Published var cardnameModel = CardNameValidator()
    @Published var cardNumberModel = CardNumberValidator()
    @Published var cardExpModel = CardExpProxy()
    @Published var cardCVCModel = CardCVCProxy()
    @Published var isValidCard: Bool = false
    
    var bag: Set<AnyCancellable> = []
    
    public init() {
        Publishers.CombineLatest(cardNumberModel.$cardBrand, cardCVCModel.$data).sink { brand, cvc in
            self.cardCVCModel.validateCVV(brand: brand, text: cvc)
        }.store(in: &bag)
        
        Publishers.CombineLatest4(cardnameModel.$state, cardNumberModel.$state, cardExpModel.$state, cardCVCModel.$state).sink { nameState, numberState, expState, cvvState in
            if nameState == .success && numberState == .success && expState == .success && cvvState == .success {
                self.isValidCard = true
            } else {
                self.isValidCard = false
            }
            
        }.store(in: &bag)
    }
    
    func saveCard() {
        let brand = cardNumberModel.cardBrand.rawValue
        let dpOperationDate = DateFormatter.dateOnly.string(from: Date())
        let card = CardInfo(name: cardnameModel.data,
                            number: cardNumberModel.data,
                            expiry: cardExpModel.dateString,
                            cvc: cardCVCModel.data,
                            createdAt: dpOperationDate,
                            brand: brand)
        do {
            try DBManager.shared.store(card: card)
        } catch {
            print(error.localizedDescription)
        }
    }
}
