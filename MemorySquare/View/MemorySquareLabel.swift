//
//  MemorySquareLabel.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/1/20.
//

import UIKit


class MemorySquareLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }

}
