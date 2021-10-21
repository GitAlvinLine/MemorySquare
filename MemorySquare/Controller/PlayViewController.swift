//
//  PlayViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 9/26/20.
//

import UIKit
import CoreData
import AVFoundation

class PlayViewController: UIViewController {
    
    @IBOutlet weak var collectionGrid: UICollectionView!
    @IBOutlet weak var levelNumber: UILabel!
    
    
    private let numberIndex = [0,1,2,3,4,5,6,7,8]
    private var ComputerRandomCellArray: [Int] = []
    private var UserInputCellArray: [Int] = []
    
    private var timer: Timer!
    private var gridTimer: Timer!
    private var setBackTimer: Timer!
    private var gameTimerClock: Timer!
    
    private var countDownToBeginPattern = NumberLabel()
    private var timeForUser = GameTimer()
    private var goLabel = GoIndicatorLabel()
    
    private var counter = 0
    private var counterForGrid = Config.patternLimit
    
    private var player: AVAudioPlayer?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var task: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionGrid.delegate = self
        collectionGrid.dataSource = self
        
        Config.playerSound.prepareToPlay()

        levelNumber.text = "Level \(Config.showUserLevel)"
        
        self.collectionGrid.isUserInteractionEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        countDownToBeginPattern = NumberLabel(frame: CGRect(x: (self.view.frame.width / 2) - 50, y: (self.view.frame.height / 2) - 150, width: 100, height: 300))
        self.view.addSubview(countDownToBeginPattern)
        
        timeForUser = GameTimer(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        
        task = DispatchWorkItem {
            self.timer.invalidate()
            self.gridTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.backgroundUpdate), userInfo: nil, repeats: true)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if !timer.isValid {
            self.gridTimer.invalidate()
        }
        self.timer.invalidate()
        self.task!.cancel()
    }
    
    
    @objc func countDown() {
        if var number = Int(countDownToBeginPattern.text!) {
            number -= 1
            if countDownToBeginPattern.text == "1" {
                countDownToBeginPattern.removeFromSuperview()
            }
            countDownToBeginPattern.text = String(number)
        }
    }
    
    func evaluateUsersPattern(computerInput: [Int], userInput: [Int]) {
        if computerInput.count == userInput.count && computerInput == userInput {
        
            if Level.allCases.count == Config.counterForEnumCase + 1 {
                
                let alert = UIAlertController(title: "WINNER!", message: "You beat the last level!", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Repeat", style: .default, handler: { (UIAlertAction) in
                    self.viewDidLoad()
                    self.ComputerRandomCellArray.removeAll()
                    self.UserInputCellArray.removeAll()
                    self.counter = 0
                    self.counterForGrid = Config.patternLimit
                }))

                alert.addAction(UIAlertAction(title: "HOME", style: .default, handler: { (UIAlertAction) in
                    self.saveHighScoreLevel()
                    Config.counterForEnumCase = 0
                    Config.level = Config.numberOfCases[Config.counterForEnumCase]
                    self.ComputerRandomCellArray.removeAll()
                    self.UserInputCellArray.removeAll()
                    self.counter = 0
                    self.counterForGrid = Config.patternLimit
                    self.performSegue(withIdentifier: "HomeVC", sender: self)
                }))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "CORRECT!", message: "You remembered the pattern.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "REPEAT", style: .default, handler: { (UIAlertAction) in
                    self.viewDidLoad()
                    self.ComputerRandomCellArray.removeAll()
                    self.UserInputCellArray.removeAll()
                    self.counter = 0
                    self.counterForGrid = Config.patternLimit
                }))
                
                alert.addAction(UIAlertAction(title: "ADVANCE", style: .default, handler: { (UIAlertAction) in
                    if Level.allCases.count == Config.counterForEnumCase + 1 {
                        return
                    } else {
                        self.saveHighScoreLevel()
                        self.viewDidLoad()
                        Config.counterForEnumCase += 1
                        Config.level = Config.numberOfCases[Config.counterForEnumCase]
                        
                        self.ComputerRandomCellArray.removeAll()
                        self.UserInputCellArray.removeAll()
                        self.counter = 0
                        self.counterForGrid = Config.patternLimit
                        self.levelNumber.text = "Level \(Config.showUserLevel)"
                        
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            let alert = UIAlertController(title: "WRONG!", message: "Work on your memory", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "REPEAT", style: .default, handler: { (UIAlertAction) in
                self.viewDidLoad()
                self.ComputerRandomCellArray.removeAll()
                self.UserInputCellArray.removeAll()
                self.counter = 0
                self.counterForGrid = Config.patternLimit
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startTimerForUser() {
        
        self.timeForUser.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.timeForUser)
        
        NSLayoutConstraint.activate([
            self.timeForUser.heightAnchor.constraint(equalToConstant: 200),
            self.view.topAnchor.constraint(equalTo: self.timeForUser.topAnchor, constant: -30),
            self.view.leadingAnchor.constraint(equalTo: self.timeForUser.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.timeForUser.trailingAnchor)
        ])
        
        self.collectionGrid.isUserInteractionEnabled = true
        gameTimerClock = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (gameTimerClock) in
            
            if self.task!.isCancelled {
                self.gameTimerClock.invalidate()
            }
            if var gameTimeNumber = Int((self.timeForUser.text)!) {
                if gameTimeNumber == 0 {
                    self.timeForUser.removeFromSuperview()
                    self.timeForUser.text = String(gameTimeNumber)
                    self.gameTimerClock.invalidate()
                    self.evaluateUsersPattern(computerInput: self.ComputerRandomCellArray, userInput: self.UserInputCellArray)
                } else {
                    gameTimeNumber -= 1
                    self.timeForUser.text = String(gameTimeNumber)
                }
                
            }
        })
    }
    
    @objc func backgroundUpdate() {
        let cell = collectionGrid.indexPathsForVisibleItems.sorted()
        let randomIndex = Int.random(in: 0..<9)
        cellSounds()
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.collectionGrid.cellForItem(at: cell[randomIndex])!.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.ComputerRandomCellArray.append(randomIndex)
            if self.counter > self.counterForGrid {
                self.gridTimer.invalidate()
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (Timer) in
                    self.goLabel = GoIndicatorLabel(frame: CGRect(x: (self.view.frame.width / 2) - 150, y: (self.view.frame.height / 2) - 250, width: 300, height: 500))
                    self.view.addSubview(self.goLabel)
                }
                
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (Timer) in
                    self.goLabel.removeFromSuperview()
                    self.startTimerForUser()
                }
                
            }
            self.counter += 2
            self.counterForGrid += 1
        }, completion: nil)
        
        setBackTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { (setBackTimer) in
            self.setBackTimer.invalidate()
            UIView.animate(withDuration: 0.2) {
                self.collectionGrid.cellForItem(at: cell[randomIndex])!.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)        }
        })
    }
    
    func saveHighScoreLevel() {
        do {
            let request : NSFetchRequest<HighScore> = HighScore.fetchRequest()
            var result = [HighScore]()
            result = try context.fetch(request)
            if result.isEmpty {
                let newHighScore = HighScore(context: self.context)
                newHighScore.highestLevel = Config.showUserLevel
                try context.save()
            } else {
                if let lastHighScore = Int((result.last?.highestLevel)!),
                   let usersCurrentLevel = Int(Config.showUserLevel){
                    if usersCurrentLevel > lastHighScore {
                        let newHighScore = HighScore(context: self.context)
                        newHighScore.highestLevel = Config.showUserLevel
                        try context.save()
                    }
                }
            }
        } catch {
            debugPrint("Error saving level")
        }
    }
    
    func cellSounds() {
        Config.player?.play()
    }
    
    @IBAction func backToHomeTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }

}

extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberIndex.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionGrid.dequeueReusableCell(withReuseIdentifier: "SquareCell", for: indexPath) as? SquareCell {
            cell.customizeAppeareance(cell: cell)
            return cell
        }
        
        return SquareCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionGrid.cellForItem(at: indexPath) as? SquareCell {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            Config.player = try! AVAudioPlayer(contentsOf: Config.url!)
            Config.player?.play()
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                cell.backgroundColor = #colorLiteral(red: 0.9688121676, green: 0.9688346982, blue: 0.9688225389, alpha: 1)
            }, completion: nil)
            UserInputCellArray.append(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 3
        let spacing: CGFloat = 0.2
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (self.collectionGrid.bounds.width - totalHorizontalSpacing) / columns
        let itemHeight = (self.collectionGrid.bounds.height - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
