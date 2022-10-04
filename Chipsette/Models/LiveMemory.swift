//
//  LiveMemory.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

struct LiveMemory: Memory {
    private let memory: [UInt8]
    private let capacity: UInt16
    
    func getByte(at: UInt16) throws -> UInt8 {
        let idx = Int(at)
        
        if(at >= capacity) {
            throw MemoryError.outOfBounds
        }
        
        return memory[idx]
    }
    
    func memoryMutatingByte(at: UInt16,
                            to: UInt8) throws -> Memory {
        if(at >= capacity) {
            throw MemoryError.outOfBounds
        }
        
        let modifiedMemory = self.memory.enumerated().map { (idx, byte) in
            if(idx == at) {
                return to
            } else {
                return byte
            }
        }

        // We already know that our current memory state is valid and that program fits
        // So unless some act of God occurs, this should never throw.
        return try! LiveMemory(capacity: self.capacity,
                               initialBytes: modifiedMemory,
                               byteLoadOffset: 0)
    }
    
    init(capacity: UInt16,
         initialBytes: [UInt8]?,
         byteLoadOffset: UInt16) throws {
        let size = Int(capacity)
        
        var memoryContents = Array<UInt8>(repeating: 0,
                                          count: size)
        
        if let programContents = initialBytes {
            let offsetIdx = Int(byteLoadOffset)
            for (idx, byte) in programContents.enumerated() {
                if(idx + offsetIdx >= capacity) {
                    throw MemoryError.programTooLarge
                }
                
                memoryContents[offsetIdx + idx] = byte
            }
        }
        
        self.memory = memoryContents
        self.capacity = capacity
    }
    
    
}
