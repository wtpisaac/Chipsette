//
//  Register.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

protocol Register {
    associatedtype T
    
    var value: T { get }
    
    func mutating(to: T) -> Self
}
