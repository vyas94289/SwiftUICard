//
//  MonthYearPicker.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//

import SwiftUI

struct MonthYearPicker: View {
    static let months = Array(1 ..< 12)
    static let years = Array(2020 ..< 2080)
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker("", selection: $selectedMonth) {
                    ForEach(MonthYearPicker.months, id: \.self) {
                        Text(String(format: "%02d", $0)).tag($0)
                    }
                }
                .labelsHidden()
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: geometry.size.width / 2, height: 160)
                .clipped()

                Picker("", selection: $selectedYear) {
                    ForEach(MonthYearPicker.years, id: \.self) {
                        Text(String($0)).tag($0)
                    }
                }
                .labelsHidden()
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: geometry.size.width / 2, height: 160)
                .clipped()

            }.background(
                RoundedRectangle(cornerRadius: 20).fill(Color(#colorLiteral(red: 0.1838568653, green: 0.1838568653, blue: 0.1838568653, alpha: 1)))
            )
        }
        .frame(height: 160)
        .mask(Rectangle())
    }
}
