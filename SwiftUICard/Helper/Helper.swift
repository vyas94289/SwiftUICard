//
//  Helper.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import Foundation

class Helper: NSObject {
    static var documentsDirectoryPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
