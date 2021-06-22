//
//  DBManager+CardTable.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import SQLite
import Foundation

extension DBManager {
    func store(card: CardInfo) throws {
        let cardTable = DBTable.cards.table
        guard db !=  nil else {
            throw CustomError(description: "Database Not connected")
        }
        let setters = try card.prepareInsertMessageSetter()
        try db!.run(cardTable.insert(setters))
    }
    
    func fetchAllCards() throws -> [CardInfo] {
        guard db !=  nil else {
            throw CustomError(description: "Database not connected")
        }
        var arrCard: [CardInfo] = []
        
        let query = DBTable.cards.table.select(*).order(DBExpression.cardId.desc)
        let rowSequence = try db!.prepare(query)
        for row in rowSequence {
            arrCard.append(try CardInfo(row: row))
        }
        return arrCard
    }
    
    func deleteCard(id: Int) throws {
        guard db !=  nil else {
            throw CustomError(description: "Database not connected")
        }

        let deleteQuery = DBTable.cards.table.filter(DBExpression.cardId == id)
        try db!.run(deleteQuery.delete())
    }
}
