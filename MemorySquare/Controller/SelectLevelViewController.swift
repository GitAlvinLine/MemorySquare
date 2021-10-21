//
//  SelectLevelViewController.swift
//  MemorySquare
//
//  Created by Alvin Escobar on 11/7/20.
//

import UIKit

class SelectLevelViewController: UIViewController {
    
    @IBOutlet weak var userSelectedLevelText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userSelectedLevelText.delegate = self
        self.userSelectedLevelText.addDoneButtonOnKeyBoard()
        
    }
    
    func isLevelValid(fromUser: UITextField) -> Bool {
        guard let userSelectedLevel = Int(fromUser.text!) else { return false}
        if userSelectedLevel > 10 || userSelectedLevel < 1 {
            return false
        }
        return true
    }
   
    
    @IBAction func playLevelButtonTapped(_ sender: UIButton) {
        let levelValid = isLevelValid(fromUser: userSelectedLevelText)
        if levelValid{
            let numberLevel = Int(userSelectedLevelText.text!)!
            let levelSelect = Config.intToType(value: numberLevel)
            Config.level = levelSelect
            Config.counterForEnumCase = numberLevel - 1
            performSegue(withIdentifier: "PlayVC", sender: self)
        }
        let alert = UIAlertController(title: "Error", message: "Please Select a level from 1 - 10", preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func backToHomeVC(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
}

extension SelectLevelViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UITextField {
    
    func addDoneButtonOnKeyBoard() {
        let doneToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolBar.barStyle = .default
        
        let flexspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexspace, done]
        doneToolBar.items = items
        doneToolBar.sizeToFit()
        
        self.inputAccessoryView = doneToolBar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
