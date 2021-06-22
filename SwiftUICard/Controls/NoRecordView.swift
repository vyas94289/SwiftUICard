//
//  NoRecordView.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import SwiftUI

enum NoRecordType {
    case noRecord
    case error
    
    var image: String {
        switch self {
        case .noRecord:
            return "noRecords"
        case .error:
            return "error"
        }
    }
}

struct NoRecordView: View {
    var type: NoRecordType
    var title: String
    var message: String
    var body: some View {
        VStack(spacing: 20) {
            Image(type.image)
            Text(title).font(.body)
            Text(message).foregroundColor(Color.gray).font(.caption)
        }
    }
}

