//
//  Keypad.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import Foundation

protocol Keypad {
    func registerHandler(_ inputHandler: KeypadInputHandler)
    func keyPressed(_: Key)
}
