//
//  CardView.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 03/02/21.
//

import SwiftUI
import Neumorphic

struct CardView: View {
    let card: CardInfo
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image("card_chip").padding(.top, 10)
                    Spacer()
                    Image(card.stripeCardBrand.icon)
                }
                
                Text(card.cardNumberFormatted).font(.title2)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CARD HOLDER").font(.caption)
                        Text(card.cardHolder.uppercased())
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Text("EXPIRES").font(.caption)
                        Text(card.cardExpiry)
                    }
                }.padding(.top, 10)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .background(RoundedRectangle(cornerRadius: 20).fill(Neumorphic.shared.mainColor()).softOuterShadow())
        }.padding(.horizontal, 20)
        
    }
}
