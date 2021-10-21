//
//  NumberLabel.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 10/1/20.
//

import UIKit

class NumberLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .left
        self.font = UIFont(name: "Avenir", size: 150)
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.text = "3"
    }

}
