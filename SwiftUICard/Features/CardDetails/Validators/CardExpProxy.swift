//
//  CardExpProxy.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//

import Combine
import Foundation
import Stripe

class CardExpProxy: ObservableObject {
    
    @Published var dateString: String = ""
    @Published var data: Date = Date()
    @Published var state: TextFieldState = .normal
    @Published var errorValue: String = "Card name should be at least 3 characters"
    @Published var selectedMonth = Calendar.current.component(.month, from: Date())
    @Published var selectedYear = Calendar.current.component(.year, from: Date())
    var cancellable: AnyCancellable!
    
    public init() {
        cancellable = Publishers.CombineLatest($selectedMonth, $selectedYear).sink { month, year in
            self.dateString = "\(String(format: "%02d", month))/\(year)"
            self.validateCredentials(month: String(month), year: String(year - 2000))
        }
    }
    
    func validateCredentials(month: String, year: String) {
    
        
        var isValid = true
        
        let validatingMonth = STPCardValidator.validationState(forExpirationMonth: month)
        isValid = validatingMonth != .invalid
        
        if isValid {
            let validatingYear = STPCardValidator.validationState(forExpirationYear: year, inMonth: month)
            isValid = validatingYear != .invalid
        }
        
        state = isValid ? .success : .error
    
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}
