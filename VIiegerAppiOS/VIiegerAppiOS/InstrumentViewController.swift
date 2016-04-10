//
//  InstrumentViewController.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 09/04/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import UIKit

class InstrumentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImages()
    }

    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    var data = NSMutableData()
    
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
                             print(object)
                        }
                    } catch {
                        print("Error in parsing JSON")
                    }
                }
            }
        }
        
        dataTask?.resume()

    }
    
    
    @IBOutlet weak var questionImageLeft: UIImageView!
    @IBOutlet weak var questionImageRight: UIImageView!
    
    @IBOutlet weak var answerImageOne: UIImageView!
    @IBOutlet weak var answerImageTwo: UIImageView!
    @IBOutlet weak var answerImageThree: UIImageView!
    @IBOutlet weak var answerImageFour: UIImageView!
    
    @IBAction func AnswerButton(sender: UIButton) {
        
    }
//     Need to get images
    
    
//     Need to set images
    
//     Need to save answers
    
//     Navigation to next/previous pages
    @IBAction func navigationButton(sender: AnyObject) {
    }
    
}
