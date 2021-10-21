//
//  Config.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 10/11/20.
//

import Foundation
import AVFoundation

enum Level: CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine, ten
}

enum SelectLevel: Int {
    case one = 1, two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7 , eight = 8, nine = 9, ten = 10
}

class Config {
    static let numberOfCases = Level.allCases
    
    static var player: AVAudioPlayer?
    static let url = Bundle.main.url(forResource: "tappedOnTile", withExtension: "wav")
    
    static var playerSound: AVAudioPlayer {
        player = try! AVAudioPlayer(contentsOf: url!)
        return player!
    }
    
    static var counterForEnumCase: Int = 0
    static var level: Level = .one
    static var userSelectLevel: SelectLevel = .one
    
    static var showUserLevel: String {
        switch level {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        }
    }
    
    static func intToType(value: Int) -> Level {
        switch value {
        case 1:
            return .one
        case 2:
            return .two
        case 3:
            return .three
        case 4:
            return .four
        case 5:
            return .five
        case 6:
            return .six
        case 7:
            return .seven
        case 8:
            return .eight
        case 9:
            return .nine
        case 10:
            return .ten
        default:
            return .one
        }
    }
    
    
    static var patternLimit: Int {
        switch level {
        case .one:
            return 1
        case .two, .three:
            return 2
        case .four:
            return 3
        case .five, .six:
            return 4
        case .seven, .eight:
            return 5
        case .nine, .ten:
            return 6
        }
    }
    
    static var gridCountDownTimer: Int {
        switch level {
        case .one, .two:
            return 4
        case .three, .four:
            return 5
        case .five, .six:
            return 6
        case .seven, .eight:
            return 7
        case .nine, .ten:
            return 8
        }
    }
}
