//
//  CardNumberValidator.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//

import SwiftUI
import Combine
import Stripe

class CardNumberValidator: ObservableObject {
    @Published var data: String = ""  {
        didSet {
            let filtered = data.filter { $0.isNumber }
            if data != filtered {
                data = filtered
            }
        }
    }
    @Published var state: TextFieldState = .normal
    @Published var errorValue: String = "Card number should be 16 character"
    @Published var cardIcon: String = Images.debitCard
    @Published var cardBrand: STPCardBrand = STPCardBrand.unknown
    
    var cancellable: AnyCancellable!
    
    public init() {
        cancellable = $data.sink { value in
            self.validateCredentials(value)
        }
    }
    
    func validateCredentials(_ value: String) {
        guard !value.isEmpty else {
            state = .normal
            cardIcon = Images.debitCard
            return
        }
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: value)
        if  !allowedCharacters.isSuperset(of: characterSet) {
            state = .error
            return
        }
        if value.count > 19 {
            state = .error
            return
        }
        
        let validatingCardBrand = STPCardValidator.validationState(forNumber: value,
                                                                   validatingCardBrand: true)
        
        switch validatingCardBrand {
        case .valid:
            state = .success
        case .invalid:
            state = .error
        case .incomplete:
            state = .incomplete
        }
        
        if validatingCardBrand == .invalid {
            cardIcon = Images.debitCardError
         } else {
            cardIcon = StripeCardImage.getImage(for: value)
         }
        cardBrand = STPCardValidator.brand(forNumber: value)
         
    }
    
    func modifyCreditCardString(creditCardString: String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if arrOfCharacters.count > 0 {
            for index in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[index])
                if (index+1) % 4 == 0 && index+1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}

