//
//  LiveSprite.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import Foundation

struct LiveSprite: Sprite {
    var bytes: [UInt8]
    
    init(bytes: [UInt8]) throws {
        if(bytes.count != 5) {
            throw SpriteErrors.invalidByteFormat
        }
        self.bytes = bytes
    }
    
    
}
