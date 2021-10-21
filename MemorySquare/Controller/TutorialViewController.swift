//
//  TutorialViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 9/26/20.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "tutorialPart1VC", sender: self)
    }
    
    @IBAction func backToHomeTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func unwindToFirstTutorialVC(_ seg: UIStoryboardSegue) {
        
    }
    
}
