//
//  ListeningGame.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 10/04/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import Foundation

class ListeningGame {
    
    internal var isPaused: Bool = false
    internal var round: Int = 1
    internal var score: Int = 0
    
    private var leaderboardKey: String = "CgkIgozg9vQREAIQAQ"
    
    var a: Int = 0
    
    internal var hearedNumbers: Array<Int> = Array<Int>()
    
    func submitAnswer(number: Int) {
        hearedNumbers.append(number)
        print("Answering: The answer \(number) has been added to hearedNumbers")
    }
    
    func playRound() {
//        let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
//        let queue = dispatch_get_global_queue(qos, 0)
//        
//        let delay = Int64(1*Double(NSEC_PER_MSEC))
        
        let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            
        }

        /*
        Thread t = new Thread(new Runnable() {
        
            @override
            public run() {
                List<Integer> playedNumbers = new ArrayList<>(); // the max amount of numbers is 8 so we should be fine
                // set array of answered numbers
                hearedNumbers = new ArrayList<>();
        
                while(a<5) {
                    while (isPaused) {
                        sleep(1);
                    }
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        e.printStacktrace();
                    }
                    a++
                }
                Log.e("round", "answer time enabled");
                try {
                    Thread.sleep(8000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                if(!checkMistakeMade(playedNumbers, hearedNumbers)) {
                    score++;
                }
                Log.e("round", "ended round: " + round);
                a = 0;
            }
        });
        
        t.start();
        
        try {
            t.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        */
    }
    
    internal func doInBackground() {
        while (round < 24 && !isPaused) {
            playRound()
            round++
        }
    }
    
    
}