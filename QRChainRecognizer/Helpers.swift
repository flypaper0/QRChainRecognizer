//
//  Helpers.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

typealias VoidBlock = () -> Void

var documentsDirectory: URL  {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
