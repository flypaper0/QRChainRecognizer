//
//  PaymentInfo.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct PaymentInfo {
    
    let paymentId: String
    let nickname: String
    let avatar: UIImage
    
    init(paymentId: String, nickname: String, avatar: UIImage) {
        self.paymentId = paymentId
        self.nickname = nickname
        self.avatar = avatar
    }

}

// MARK: - ChainingProtocol

extension PaymentInfo: ChainingProtocol {
    
    init(json: [String: Any]) throws {
        
        guard let paymentId = json["paymentId"] as? String,
            let nickname = json["nickname"] as? String,
            let avatarData =  json["avatar"] as? Data,
            let avatar = UIImage(data: avatarData, scale: 1.0) else {
                throw ParsingError.paymentInfo
        }
        
        self.paymentId = paymentId
        self.nickname = nickname
        self.avatar = avatar
    }
    
    var json: [String: Any] {
        return [
            "paymentId": paymentId,
            "nickname": nickname,
            "avatar": UIImageJPEGRepresentation(avatar, Constants.imageScale) ?? ""
        ]
    }
    
}

