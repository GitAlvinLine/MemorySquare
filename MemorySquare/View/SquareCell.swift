//
//  SquareCell.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 10/1/20.
//

import UIKit

class SquareCell: UICollectionViewCell {
    
    func customizeAppeareance(cell: UICollectionViewCell) {
        cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 2
        
    }

}
