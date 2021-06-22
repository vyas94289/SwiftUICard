//
//  CustomError.swift

//
//  Created by Sagar Thummar on 13/09/18.
//  Copyright © 2019 Solution Analysts Pvt. Ltd. All rights reserved.
//

import Foundation

struct CustomError: CustomNSError, LocalizedError {

    var errorDomain: String
    var errorCode: Int
    var failureReason: String?
    var errorDescription: String
    var data: Any?

    init(failureReason reason: String? = nil, description: String, infoData: Any? = nil) {
        errorDomain = CMError.chatDomain
        errorCode = CMError.code400
        failureReason = reason
        errorDescription = description
        data = infoData
    }
}

enum CMError {
    static let chatDomain = "ChatModule"
    static let code400 = 400
}
