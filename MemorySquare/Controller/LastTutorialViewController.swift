//
//  LastTutorialViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/9/20.
//

import UIKit

class LastTutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "backOneTutorialPart", sender: self)
    }
    
    @IBAction func backToHomeTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    

}
