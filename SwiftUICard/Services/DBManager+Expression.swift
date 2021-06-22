//
//  DBManager+Expression.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation
import SQLite

enum DBExpression {
    static let cardId = Expression<Int>("cardId")
    static let cardHolder = Expression<String>("cardHolder")
    static let number = Expression<String>("number")
    static let expiry = Expression<String>("expiry")
    static let cvc = Expression<String>("cvc")
    static let createdAt = Expression<String>("createdAt")
    static let brand = Expression<Int>("brand")
}

enum CardField {
    case cardId
    case cardHolder
    case number
    case expiry
    case cvc
    case createdAt
    case brand
}
