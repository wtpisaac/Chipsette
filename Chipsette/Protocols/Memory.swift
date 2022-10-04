//
//  Memory.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

/// Protocol for any model which implements memory storage and access for a CHIP-8 Computer
/// Enables setting and getting bytes, along with an initializer for loading the initial ROM into it
/// (No blank ROM offered, as the interpreter won't be useful without a program)
protocol Memory {
    /// Get byte value at the specified offset
    func getByte(at: UInt16) throws -> UInt8
    
    /// Get a copy of the Memory state struct given the desired change to memory location
    func memoryMutatingByte(at: UInt16,
                            to: UInt8) throws -> any Memory
    
    /// Initialize the memory with the specified capacity, initial program data, and the offset at which to load the program
    init(capacity: UInt16,
         initialBytes: [UInt8]?,
         byteLoadOffset: UInt16) throws
}
