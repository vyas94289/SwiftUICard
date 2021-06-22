//
//  Images.swift
//  SwiftUICard
//
//  Created by Gaurang Vyas on 01/02/21.
//

import Foundation
import Stripe

enum Images {
    static let dinersClub = "DinersClub_stp"
    static let amex = "Amex_stp"
    static let discover = "Discover_stp"
    static let jcb = "JCB_stp"
    static let mastercard = "Mastercard_stp"
    static let visa = "Visa_stp"
    static let debitCardError = "debit_card_error_str"
    static let debitCard = "debit_card_str"
}


class StripeCardImage: NSObject {
    
    static func getImage(for cardNumber: String) -> String {
        switch STPCardValidator.brand(forNumber: cardNumber) {
        case .visa:
            return Images.visa
        case .amex:
            return Images.amex
        case .discover:
            return Images.discover
        case .JCB:
            return Images.jcb
        case .dinersClub:
            return Images.dinersClub
        case .unionPay:
            return Images.debitCard
        case .mastercard:
            return Images.mastercard
        case .unknown:
            return Images.debitCard
        }
    }
}

extension STPCardBrand {
    var icon: String {
        switch self {
        case .visa:
            return "stp_card_visa"
        case .amex:
            return "stp_card_amex"
        case .discover:
            return "stp_card_amex"
        case .JCB:
            return "stp_card_jcb"
        case .dinersClub:
            return "stp_card_diners"
        case .unionPay:
            return "stp_card_unionpay_en"
        case .mastercard:
            return "stp_card_mastercard"
        default:
            return "stp_card_unknown"
        }
    }
}
