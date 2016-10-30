//
//  ViewController.swift
//  7-Swifty-Words
//
//  Created by Brian Wong on 10/30/16.
//  Copyright © 2016 Brian Wong. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    //Instead of updating the score everywhere we potentially change it. Using a property observer here makes every change to the score synchronized with the score label!
    var score: Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instead of creating an outlet for each button, assign each button a target using the common tag amongst them
        for subview in view.subviews where subview.tag == 1001
        {
            let button = subview as! UIButton
            letterButtons.append(button)
            button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        
        loadLevel()
    }
    
    //Parse necessary game info from text file - We can create as many txt files as we want for a new level, but have to make sure we have a group of 20 word bits!
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt"){
            if let levelContents = try? String(contentsOfFile: levelFilePath){
                var lines = levelContents.components(separatedBy: "\n")
                lines.remove(at: lines.count - 1)//The last item in our array is just a '\n' so remove it to avoid parsing it.
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String] //Shuffle up our array of words
                
                for(index, line) in lines.enumerated(){//Enumerated() is a special type of loop which gives us the index AND item at each index in the array
                    let parts = line.components(separatedBy: ": ")//Separate word from hint
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "") //Remove pipes to get full word/answer
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|") //Get chunks of words 
                    letterBits += bits;
                }
            }
        }
        
        //Now we can configure buttons and labels
        
        //Trim last line break added in cluesLabel and answersLabel
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Shuffle up our letters and set them in our button grid
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }

    
    func letterTapped(button: UIButton){
        currentAnswer.text = currentAnswer.text! + button.titleLabel!.text!
        activatedButtons.append(button)
        button.isHidden = true;
    }
    
    
    @IBAction func clearTapped(_ sender: AnyObject) {
        currentAnswer.text = ""
        
        for btn in activatedButtons{
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    @IBAction func submitTapped(_ sender: AnyObject) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!){//Check if current word guessed is in our solutions
            activatedButtons.removeAll()
            
            var splitClues = answersLabel.text!.components(separatedBy: "\n")//Get all clues separately
            splitClues[solutionPosition] = currentAnswer.text! //Replace clue with respective answer
            answersLabel.text = splitClues.joined(separator: "\n")//Join clues with new answer to display
            
            //Add score and reset if they guessed the word right
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 //If user's score is 7, they beat this level!
            {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }else{
            clearTapped(self)
            
            currentAnswer.text = ""
            score -= 1
        }
    }
    
    func levelUp(action: UIAlertAction!) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }

}

