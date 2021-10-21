//
//  GoIndicatorLabel.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/11/20.
//

import UIKit

class GoIndicatorLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.textAlignment = .center
        self.font = UIFont(name: "Avenir", size: 200)
        self.font = UIFont.systemFont(ofSize: 200, weight: .medium)
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.text = "GO"
    }

}
