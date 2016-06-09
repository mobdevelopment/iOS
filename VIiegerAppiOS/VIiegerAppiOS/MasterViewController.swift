//
//  MasterViewController.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 08/06/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
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
                        // Loop for every question
                        for question in jsonResult {
                            let id = question["id"] as! Int
                            // altitude data
                            let altitude_id = question["altitude"]!!["id"] as! Int
                            let altitude_path = question["altitude"]!!["path"] as! String
                            let altitude = Image(_id: altitude_id, _path: altitude_path, _correct: false)
                            // compass data
                            let compass_id = question["compass"]!!["id"] as! Int
                            let compass_path = question["compass"]!!["path"] as! String
                            let compass = Image(_id: compass_id, _path: compass_path, _correct: false)
                            
                            var answerArray: [Image] = []
                            // Loop for every answer (image) in a question
                            if let images = question["images"] as? NSArray {
                                for image in images {
                                    let image_id = image["id"] as! Int
                                    let image_path = image["path"] as! String
                                    let image_correct = image["correct"] as! Bool
                                    answerArray.append(Image(_id: image_id, _path: image_path, _correct: image_correct))
                                }
                                let q = Question(_id: id, _altitude: altitude, _compass: compass, _images: answerArray)
                                self.insertNewQuestion(q)
                                
                            }
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

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewQuestion(question: Question) {
        objects.insert(question, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! Question
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! Question
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

