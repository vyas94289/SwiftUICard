//
//  CardInfo.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation
import SQLite
import Stripe

class CardInfo: Identifiable {
    var cardId: Int?
    let cardHolder: String
    let cardNumber: String
    let cardExpiry: String
    let cardCVC: String
    let cardBrand: Int
    let createdAt: String
    
    var stripeCardBrand: STPCardBrand {
        return STPCardBrand(rawValue: cardBrand) ?? .unknown
    }
    
    var cardNumberFormatted: String {
        let arrOfCharacters = Array(cardNumber)
        var modifiedCreditCardString = ""
        if arrOfCharacters.count > 0 {
            for index in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[index])
                if (index+1) % 4 == 0 && index+1 != arrOfCharacters.count {
                    modifiedCreditCardString.append("  ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    init(id: Int? = nil, name: String, number: String, expiry: String, cvc: String, createdAt: String, brand: Int) {
        cardId = id
        cardHolder = name
        cardNumber = number
        cardExpiry = expiry
        cardCVC = cvc
        cardBrand = brand
        self.createdAt = createdAt
    }
    
    func prepareInsertMessageSetter() throws -> [Setter] {
        return [
            DBExpression.cardHolder <- cardHolder,
            DBExpression.number <- cardNumber,
            DBExpression.expiry <- cardExpiry,
            DBExpression.cvc <- cardCVC,
            DBExpression.brand <- cardBrand,
            DBExpression.createdAt <- createdAt
        ]
    }
    
    func prepareUpdateMessageSetter() throws -> [Setter] {
        guard let id = self.cardId else {
            throw CustomError(description: "Card id is missing!")
        }
        var setters = try prepareInsertMessageSetter()
        setters.append(DBExpression.cardId <- id)
        return setters
    }
}

//MARK : - Database Operations
extension CardInfo {
    
    convenience init(row: Row) throws {
      
        let cardID: Int = try CardInfo.getValueFor(row: row, field: CardField.cardId)
        let name: String = try CardInfo.getValueFor(row: row, field: CardField.cardHolder)
        let number: String = try CardInfo.getValueFor(row: row, field: CardField.number)
        let expiry: String = try CardInfo.getValueFor(row: row, field: CardField.expiry)
        let cvc: String = try CardInfo.getValueFor(row: row, field: CardField.cvc)
        let brand: Int = try CardInfo.getValueFor(row: row, field: CardField.brand)
        let createdAt: String = try CardInfo.getValueFor(row: row, field: CardField.createdAt)
        
        self.init(id: cardID, name: name, number: number, expiry: expiry, cvc: cvc, createdAt: createdAt, brand: brand)
    }
    
    static func getValueFor<T>(row: Row, field: CardField) throws -> T {
        switch field {
        case .cardId:
            if let value = try row.get(DBExpression.cardId) as? T {
                return value
            }
            throw CustomError(description: "Card id not found")
        case .cardHolder:
            if let value = try row.get(DBExpression.cardHolder) as? T {
                return value
            }
            throw CustomError(description: "Card name not found")
        case .number:
            if let value = try row.get(DBExpression.number) as? T {
                return value
            }
            throw CustomError(description: "Card number not found")
        case .expiry:
            if let value = try row.get(DBExpression.expiry) as? T {
                return value
            }
            throw CustomError(description: "Card expiry not found")
        case .cvc:
            if let value = try row.get(DBExpression.cvc) as? T {
                return value
            }
            throw CustomError(description: "Card cvc not found")
        case .createdAt:
            if let value = try row.get(DBExpression.createdAt) as? T {
                return value
            }
            throw CustomError(description: "Card createdAt not found")
        case .brand:
            if let value = try row.get(DBExpression.brand) as? T {
                return value
            }
            throw CustomError(description: "Card brand not found")
        }
        
    }
}
