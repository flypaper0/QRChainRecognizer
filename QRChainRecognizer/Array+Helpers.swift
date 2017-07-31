//
//  Array+Helpers.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 30/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


extension Array where Element == Data {
    
    var data: Data {
        var mutableData = Data()
        for chunk in self {
            mutableData.append(chunk)
        }
        return mutableData
    }
    
}
