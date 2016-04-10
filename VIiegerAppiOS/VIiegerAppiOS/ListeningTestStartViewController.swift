//
//  ListeningTestStartViewController.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 10/04/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import UIKit

class ListeningTestStartViewController: UIViewController {
    
    private var isPlaying: Bool = false
    private var isPaused: Bool = false
    private var round: Int = 0
    private var score: Int = 0
    private var scoreModified: Bool = false
    private var reachedLimit = false
    private var started: Bool = false
    
    private var hearedNumbers: Array<Int> = Array<Int>()
    private var numberStack: Array<String> = Array<String>()
    var a: Int = 0
    
//    private var game = ListeningGame()
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBAction func numberButton(sender: UIButton) {
//        if sender.currentTitle != "⌫" {
            numberStack.append(sender.currentTitle!)
            print("numberstack = \(numberStack)")
//        } else {
//            numberStack.popLast()
//            print("numberstack = \(numberStack)")
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isPlaying {
            isPlaying = !isPlaying
            if !started {
                started = true
                startTheGame()
//                game.execute()
            } else {
//                game.resume()
            }
//            startTheGame()
        } else {
            isPlaying = !isPlaying
//            pauseTheGame()
//            game.pause
        }
    }
    
    private func startTheGame() {
        print("start listening")
        round = 1
        roundLabel.text = "Round: \(round)"
        score = 0
        while round < 24 && isPlaying {
            playRound()
            round++
        }
        // send a message to the user with his score
        print("Ended the game in round \(round) with \(score) mistakes")
        
        stopTheGame()
    }
    
    private func pauseTheGame() {
        print("paused listening")
    }
    
    private func stopTheGame() {
        print("Stopped listening")
        pauseTheGame()
        round = 0
        score = 0
        isPlaying = false
    }
    
    private func playRound() {
//        var i = 0
//        
//        while i < 2 {
//            i = i+i// temp for err reasons
//        }
        let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            
//            var playedNumbers: Array<Int> = Array<Int>()
            self.hearedNumbers = Array<Int>()
            
            while (self.a < 5) {
                while self.isPaused {
                    // sleep(1)
                }
                //a++
            }
            
        }
        
        
    }
    
    private func playSoundRight(id: Int) {
        playSound(1, right: 0, resource: id)
    }
    
    private func playSoundLeft(id: Int) {
        playSound(0, right: 1, resource: id)
    }
    
    private func playSound(left: Int, right: Int, resource: Int) {
        
    }
    
    private func randNumber() -> Int {
        let random = Int(arc4random_uniform(9) + 1)
        print(random)
        return random
    }
    
    private func randCharac() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        
        let charCount = UInt32(letters.characters.count)
        var randomString = ""
        
        let randomNum = Int(arc4random_uniform(charCount))
        let newCharacter = letters[letters.startIndex.advancedBy(randomNum)]
        randomString += String(newCharacter)
        print(randomString)
        return randomString
    }
    
//    private static func checkMistakeMade (played: , heared) -> Bool {
//    
//    }
    
}
