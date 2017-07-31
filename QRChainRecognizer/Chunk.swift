//
//  Chunk.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct Chunk {
    
    let index: Int
    let count: Int
    let payload: Data
    
    init(index: Int, count: Int, payload: Data) {
        self.index = index
        self.count = count
        self.payload = payload
    }
    
    init(data: Data) throws {
        guard let json = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any],
            let index = json["index"] as? Int, let count = json["count"] as? Int,
            let payload = json["payload"] as? Data else {
            throw ParsingError.chunk
        }

        self.index = index
        self.count = count
        self.payload = payload
    }

}

// MARK: - JSONRepresentationProtocol

extension Chunk: JSONRepresentationProtocol {
    
    var json: [String: Any] {
        return [
            "index": index,
            "count": count,
            "payload": payload
        ]
    }
    
}

// MARK: -

extension Chunk: Equatable, Hashable {
    
    static func ==(lhs: Chunk, rhs: Chunk) -> Bool {
        return lhs.index == rhs.index
    }
    
    var hashValue: Int {
        return index.hashValue
    }
    
}
