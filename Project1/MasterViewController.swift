//
//  MasterViewController.swift
//  Project1
//
//  Created by Robert McBryde on 04/09/2015.
//  Copyright © 2015 Robert McBryde. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fileManager = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!

        do {
            let items:[String] = try fileManager.contentsOfDirectoryAtPath(path)
            
        for item in items {
            if item.hasPrefix("nssl") {
                objects.append(item)
            }
        }
        
        } catch {
            print("Something went wrong trying to get the main bundle resource path")
        }
       
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailViewController = (segue.destinationViewController as! UINavigationController).topViewController  as! DetailViewController
                detailViewController.detailItem = objects[indexPath.row]
                detailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                detailViewController.navigationItem.leftItemsSupplementBackButton = true
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

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



}

