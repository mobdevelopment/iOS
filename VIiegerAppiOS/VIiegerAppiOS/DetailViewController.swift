//
//  DetailViewController.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 08/06/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var QuestionNameLabel: UILabel!
    @IBOutlet weak var QuestionCompassView: UIImageView!
    @IBOutlet weak var QuestionAltitudeView: UIImageView!
    
    @IBOutlet weak var QuestionAnswerAView: UIImageView!
    @IBOutlet weak var QuestionAnswerBView: UIImageView!
    @IBOutlet weak var QuestionAnswerCView: UIImageView!
    @IBOutlet weak var QuestionAnswerDView: UIImageView!

    var detailItem: Question! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem {
            if let nameLabel = self.QuestionNameLabel {
                nameLabel.text = detail.name
            }

            load_image(detail.compass.path, viewName: "QuestionCompassView")
            load_image(detail.altitude.path, viewName: "QuestionAltitudeView")
            
            load_image(detail.images[0].path, viewName: "QuestionAnswerAView")
            load_image(detail.images[1].path, viewName: "QuestionAnswerBView")
            load_image(detail.images[2].path, viewName: "QuestionAnswerCView")
            load_image(detail.images[3].path, viewName: "QuestionAnswerDView")
        }
    }
    
    func load_image(urlString: String, viewName: String) {
        print(urlString)
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (resonse: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    switch viewName {
                    case "QuestionCompassView" :
                        self.QuestionCompassView.image = UIImage(data: imageData)
                    case "QuestionAltitudeView" :
                        self.QuestionAltitudeView.image = UIImage(data: imageData)
                    case "QuestionAnswerAView" :
                        self.QuestionAnswerAView.image = UIImage(data: imageData)
                    case "QuestionAnswerBView" :
                        self.QuestionAnswerBView.image = UIImage(data: imageData)
                    case "QuestionAnswerCView" :
                        self.QuestionAnswerCView.image = UIImage(data: imageData)
                    case "QuestionAnswerDView" :
                        self.QuestionAnswerDView.image = UIImage(data: imageData)
                    default :
                        print("Something went wrong")
                    }
                    
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favoriteCall(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setInteger(self.detailItem.id, forKey: "favorite")
        self.configureView()
    }

}

