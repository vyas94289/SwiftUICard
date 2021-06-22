//
//  CardNameProxy.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//
import Combine
import Foundation
import Stripe

class CardNameValidator: ObservableObject {
    
    @Published var data: String = ""
    @Published var state: TextFieldState = .normal
    @Published var errorValue: String = "Card name should be at least 3 characters"
    
    var cancellable: AnyCancellable!
    
    public init() {
        cancellable = $data.sink { value in
            self.validateCredentials(value)
        }
    }
    
    func validateCredentials(_ value: String) {
        if value.isEmpty {
            state = .normal
        } else if value.count > 2 {
            state = .success
        } else {
            state = .error
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
}
