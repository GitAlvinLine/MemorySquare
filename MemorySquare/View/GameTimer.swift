//
//  GameTimer.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 10/6/20.
//

import UIKit

class GameTimer: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .center
        self.font = UIFont(name: "Avenir", size: 100)
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.text = String(Config.gridCountDownTimer)
    }
    
}
