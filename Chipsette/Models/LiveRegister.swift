//
//  LiveRegister.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

struct LiveRegister<T>: Register {
    var value: T
    
    func mutating(to: T) -> LiveRegister {
        return LiveRegister<T>(value: to)
    }
}
