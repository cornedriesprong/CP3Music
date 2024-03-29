//
//  Pitch.swift
//  CP3Music
//
//  Created by Corné on 23/02/2020.
//  Copyright © 2020 cp3.io. All rights reserved.
//

import UIKit

public struct Pitch: Hashable {
    
    public var midiNoteNumber: Int8
    
    public var octave: Int8 {
        return Int8(floor(Float(midiNoteNumber) / 12))
    }
    
    public var `class`: Class {
        return Class(rawValue: midiNoteNumber % 12)!
    }
    
    public init(midiNoteNumber: Int8) {
        self.midiNoteNumber = midiNoteNumber
    }
    
    public init(_ class: Class, _ accidental: Accidental = .natural, _ octave: Int8) {
        self.midiNoteNumber = `class`.rawValue + accidental.rawValue + octave * 12
    }
    
    public func interval(to pitch: Pitch) -> Interval? {
        
        let value = pitch.midiNoteNumber - self.midiNoteNumber
        
        if value < 0 {
            let reversedValue = value * -1
            return Interval(rawValue: reversedValue)!.inverse()
            
        } else {
            return Interval(rawValue: value)!
        }
    }
}

extension Pitch {
    
    public enum Class: Int8, Hashable, CaseIterable, CustomStringConvertible {
        case c, cs, d, ds, e, f, fs, g, gs, a, `as`, b
        
        // TODO: add flats to descriptions based on accidental
        public var description: String {
            switch self {
            case .c:
                return "C"
            case .cs:
                return "C#"
            case .d:
                return "D"
            case .ds:
                return "D#"
            case .e:
                return "E"
            case .f:
                return "F"
            case .fs:
                return "F#"
            case .g:
                return "G"
            case .gs:
                return "G#"
            case .a:
                return "A"
            case .as:
                return "A#"
            case .b:
                return "B"
            }
        }
        
        public init(midiNoteNumber: Int8) {
            let modPitch = mod(midiNoteNumber, 12)
            self.init(rawValue: modPitch)!
        }
    }
}

extension Pitch: CustomStringConvertible {
    
    public var description: String {
        let octaveNumber = Int(floor(Double(midiNoteNumber) / 12.0))
        return "\(self.class.description)\(octaveNumber)"
    }
}
