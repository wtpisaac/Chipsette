//
//  LiveStack.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

struct LiveStack: Stack {
    private let values: [UInt16]
    private let capacity: Int
    
    func stackPushing(address: UInt16) throws -> Stack {
        if(values.count + 1 > capacity) {
            throw StackError.overflow
        }
        
        var newValues = values
        newValues.append(address)
        
        return LiveStack(from: self,
                         newContents: newValues)
    }
    
    func stackPopping() throws -> (UInt16, Stack) {
        if values.isEmpty {
            throw StackError.underflow
        }
        
        var newValues = self.values
        newValues.removeLast()
        
        return (values.last!,
                LiveStack(from: self,
                          newContents: newValues))
    }
    
    init(entries: Int) {
        self.values = []
        self.capacity = entries
    }
    
    private init(from: Self,
                 newContents: [UInt16]) {
        self.values = newContents
        self.capacity = from.capacity
    }
}
