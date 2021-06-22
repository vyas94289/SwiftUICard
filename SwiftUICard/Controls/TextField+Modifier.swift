//
//  TextField+Modifier.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 29/01/21.
//

import SwiftUI

public enum TextFieldState {
    case normal
    case error
    case success
    case incomplete
    
    var color: Color {
        switch self {
        case .normal:
            return .white
        case .error:
            return .red
        case .success:
            return .green
        case .incomplete:
            return .yellow
        }
    }
}

struct PrimaryTextFieldStyle: ViewModifier {
    @Binding var state: TextFieldState
    func body(content: Content) -> some View {
        content
            .frame(height: 40)
            .padding(.horizontal, 20)
            .overlay(
                Capsule()
                    .stroke(state.color, lineWidth: 1)
            )
    }
}
