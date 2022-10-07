//
//  Sprite.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import Foundation

protocol Sprite {
    var bytes: [UInt8] { get }
    
    init(bytes: [UInt8]) throws
}
