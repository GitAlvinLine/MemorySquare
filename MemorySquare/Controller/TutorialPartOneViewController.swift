//
//  TutorialPartOneViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/8/20.
//

import UIKit

class TutorialPartOneViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        animateCountDownTimerInGrid()
    }
    
    func animateCountDownTimerInGrid() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if var label = Int(self.countDownLabel.text!) {
                label -= 1
                self.countDownLabel.text = "\(label)"
                if label == 0 {
                    Timer.invalidate()
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToStartTutorial", sender: self)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "tutorialPart2VC", sender: self)
    }
    
    @IBAction func backToHomeTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    
}
