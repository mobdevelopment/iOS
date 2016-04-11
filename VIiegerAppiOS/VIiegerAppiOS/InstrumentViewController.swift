//
//  InstrumentViewController.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 09/04/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController {
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    var data = NSMutableData()
    var isPlaying: Bool = false
    var currentRound: Int = 1
    
    var iQuestions: Array<NSDictionary> = Array<NSDictionary>()
    var iQuestionsAnswers: Array<NSDictionary> = Array<NSDictionary>()
    var roundCorrect: Dictionary<String, Bool> = Dictionary<String, Bool>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImages()
        sleep(3)
        startGame()
    }

    
    @IBOutlet weak var questionImageLeft: UIImageView!
    @IBOutlet weak var questionImageRight: UIImageView!
    
    @IBOutlet weak var answerImageOne: UIImageView!
    @IBOutlet weak var answerImageTwo: UIImageView!
    @IBOutlet weak var answerImageThree: UIImageView!
    @IBOutlet weak var answerImageFour: UIImageView!
    
    @IBAction func AnswerButton(sender: UIButton) {
        print("button pressed")
    }

//     Need to get images
    
    
//     Need to set images
    
//     Need to save answers
    
//     Navigation to next/previous pages
    @IBAction func navigationButton(sender: AnyObject) {
    }
    
    func startGame() {
        
        if !isPlaying {
            isPlaying = true
            
            while currentRound < 2 {
                playRound(currentRound)
                currentRound++
            }
            
        } else {
        }
    }
    
    func playRound(round: Int) {
        var i: Int = 1
        var o: Int = 1
        for round in iQuestions {
            if currentRound == i {
                print("round: \(i)")
            
                for r in round {
                    
                    switch String(r.key){
                    case "id":
//                        print("ik heb id")
                        break
                    case "altitude":
                        let al: NSDictionary = r.value as! NSDictionary
                        for q in al {
                            switch String(q.key) {
                            case "path":
                                load_image(q.value as! String, imageName: questionImageLeft)
//                                print("path \(q.value)")
                                break
                            default:
                                break
                            }
                        }
                    case "compass":
                        let com: NSDictionary = r.value as! NSDictionary
                        for q in com {
                            switch String(q.key) {
                            case "path":
                                load_image(q.value as! String, imageName: questionImageRight)
//                                print("path \(q.value)")
                                break
                            default:
                                break
                            }
                        }
                    case "questions":
//                        print("ik heb questions")
                        let questions = r.value
                        questions as AnyObject! as! NSArray
                        
                        for qwe in questions as! [AnyObject] {

                            let erw: NSDictionary = qwe as! NSDictionary
                            
                            for wer in erw {
                                print(wer.key)
//                                print(" ahsd")
                                print("index = \(o)")
                                switch String(wer.key) {
                                case "correct":
                                    break
                                case "id":
                                    break
                                case "path":
                                    print("kom ik heir")
                                    if o == 1 {
                                        o++
                                        print(wer.value)
                                        load_image(wer.value as! String, imageName: answerImageOne)
                                        
                                    } else if o == 2 {
                                        o++
                                        print(wer.value)
                                        load_image(wer.value as! String, imageName: answerImageTwo)
                                        
                                    } else if o == 3 {
                                        o++
                                        print(wer.value)
                                        load_image(wer.value as! String, imageName: answerImageThree)
                                        
                                    } else if o == 4 {
                                        o++
                                        print(wer.value)
                                        load_image(wer.value as! String, imageName: answerImageFour)
                                        
                                    }
                                    
                                default:
                                    break
                                }
                                
                            }
                        }
                    default:
                        break
                    }
                }
            }
            i++
        }
        
        
        
//        questionImageLeft.image =
//        questionImageRight.image =
    }
//    private var imageView = UIImageView()
//    private var image: UImage? {
//        get { return imageView.image }
//        set {
//            imageView.image = newValue
//            imageView.sizeToFit()
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    func load_image(urlString: String, imageName: UIImageView) {
//        var imgURL: NSURL = NSURL(string: urlString)!
//        let request: NSURLRequest = NSURLRequest(URL: imgURL)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            if error == nil {
//                self.imageName.image = UIImage(data: data)
//            }
//        }
        let url = NSURL(string: urlString)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imageName.image = UIImage(data: data!)
        imageName.sizeToFit()
    
    }
    
    
    
    
    func getImages() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let url =  NSURL(string: "http://imarks.org/api/question")
        dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        
                        for object in jsonResult {
                            let id = object["id"] as? Int
                            
                            let aId = object["altitude"]!!["id"] as? Int
                            let apath = object["altitude"]!!["path"] as? String
                            let altitude: NSDictionary = ["id": aId!, "path": apath!]

                            let cId = object["compass"]!!["id"] as? Int
                            let cPath = object["compass"]!!["path"] as? String
                            let compass: NSDictionary = ["id": cId!, "path": cPath!]
                            
                            var questionArray: [NSDictionary] = [NSDictionary]()
                            if let questions = object["images"] as? NSArray {
                                for question in questions {
                                    
                                    let iId = question["id"] as? Int
                                    let iPath = question["path"] as? String
                                    let iCorrect = question["correct"] as? Bool
                                    
                                    let ques: NSDictionary = ["id": iId!, "path": iPath!, "correct": iCorrect!]
                                    questionArray.append(ques)
                                }
                            }
                            let questionare: NSDictionary = ["id": id!, "altitude": altitude, "compass": compass, "questions": questionArray]
                            self.iQuestions.append(questionare)
                        }
                    } catch {
                        print("Error in parsing JSON")
                    }
                }
            }
            print("questions set")
        }
        dataTask?.resume()
    }
}
