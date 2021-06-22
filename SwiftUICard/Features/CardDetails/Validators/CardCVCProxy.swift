//
//  CardCVCProxy.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//

import Combine
import Foundation
import Stripe

class CardCVCProxy: ObservableObject {
    
    @Published var data: String = ""
    @Published var state: TextFieldState = .normal
    @Published var errorValue: String = "Card name should be at least 3 characters"
    
    func validateCVV(brand: STPCardBrand, text: String) {
        guard !text.isEmpty else {
            state = .normal
            return
        }
        let validatingCVV = STPCardValidator.validationState(forCVC: text, cardBrand: brand)
        switch validatingCVV {
        case .valid:
            state = .success
        case .invalid:
            state = .error
        case .incomplete:
            state = .incomplete
        }
        
    }
    
}
