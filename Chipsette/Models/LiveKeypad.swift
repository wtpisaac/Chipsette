//
//  LiveKeypad.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import Foundation

class LiveKeypad: Keypad {
    var handlers: [KeypadInputHandler] = []
    
    func registerHandler(_ inputHandler: KeypadInputHandler) {
        handlers.append(inputHandler)
    }
    
    func keyPressed(_ key: Key) {
        handlers.forEach { handler in
            handler.keyWasPressed(key)
        }
    }
}
