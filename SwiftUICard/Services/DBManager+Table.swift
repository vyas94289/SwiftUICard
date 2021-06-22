//
//  DBTable.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation
import SQLite

enum DBTable: String {
    case cards = "cards"
    var table: Table {
        return Table(self.rawValue)
    }
}

extension DBManager  {
    func createTables() throws {
        try createCardTable()
    }
    
    func createCardTable() throws {
        if !((try? db.scalar(DBTable.cards.table.exists)) ?? false) {
            try db.run(DBTable.cards.table.create { t in
                t.column(DBExpression.cardId, primaryKey: .autoincrement)
                t.column(DBExpression.cardHolder)
                t.column(DBExpression.number)
                t.column(DBExpression.expiry)
                t.column(DBExpression.cvc)
                t.column(DBExpression.brand)
                t.column(DBExpression.createdAt)
            })
        }
        
        
    }
}
