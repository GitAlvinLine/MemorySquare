//
//  ViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 9/26/20.
//

import UIKit
import CoreData
import AVFoundation

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var memorySquareLabel: UILabel!
    @IBOutlet weak var usersHighestLevel: UILabel!
    
    var player: AVAudioPlayer?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        usersHighestLevel.text = "Highest Level: 0"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadHighScore()
    }
    
    
    
    func loadHighScore() {
        let request : NSFetchRequest<HighScore> = HighScore.fetchRequest()
        do {
            var result = [HighScore]()
            result = try context.fetch(request)
            if result.isEmpty {
                usersHighestLevel.text = "Highest Level: 0"
            } else {
                if let highestLevel = result.last?.highestLevel {
                    usersHighestLevel.text = "Highest Level: \(highestLevel)"
                }
            }
        } catch {
            debugPrint("Error fetching data from context \(error)")
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "PlayVC", sender: self)
    }
    
    @IBAction func tutorialButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "TutorialVC", sender: self)
    }
    
    @IBAction func levelsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "SelectLevelVC", sender: self)
    }
    
    
    @IBAction func unwindToHomeVC(_ seg: UIStoryboardSegue) {
    }

}
