//
//  TutorialPartTwoViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/9/20.
//

import UIKit

class TutorialPartTwoViewController: UIViewController {
    
    @IBOutlet weak var usersCountDownLabel: UILabel!
    @IBOutlet weak var goLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeGoAfterOneSecond()
        
    }
    
    func removeGoAfterOneSecond(){
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
            self.goLabel.removeFromSuperview()
            self.animateUsersCountDownLabel()
            Timer.invalidate()
        }
    }
    
    func animateUsersCountDownLabel() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if var label = Int(self.usersCountDownLabel.text!) {
                label -= 1
                self.usersCountDownLabel.text = "\(label)"
                if label == 0 {
                    Timer.invalidate()
                }
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "backToPartOne", sender: self)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "lastTutorialPart", sender: self)
    }
    
    @IBAction func backToHomeButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    

}
