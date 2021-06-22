//
//  View+Ext.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 02/02/21.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
