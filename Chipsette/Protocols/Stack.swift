//
//  Stack.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

protocol Stack {
    func stackPushing(address: UInt16) throws -> Stack
    func stackPopping() throws -> (UInt16, Stack)
    
    /// Initialize to empty
    init(entries: Int)
}
