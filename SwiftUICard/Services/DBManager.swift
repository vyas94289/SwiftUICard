//
//  DBManages.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation
import SQLite

class DBManager: NSObject {
    static let shared = DBManager()
    var db: Connection!
    private let dbName = "database"
    private let dbExtension = "sqlite3"
    
    func connectDatabase() {
        do {
            guard let documentDirectoryURL = Helper.documentsDirectoryPath else {
                print("Failed To get document directory")
                return
            }

            let chatDatabaseURL = documentDirectoryURL.appendingPathComponent(dbName+"."+dbExtension)
            print("Database Path: \(chatDatabaseURL)")
           
            db = try Connection(chatDatabaseURL.path)
          
            try createTables()
        } catch {
            print("Database Connection Error: \(error)")
            
        }
    }
}


