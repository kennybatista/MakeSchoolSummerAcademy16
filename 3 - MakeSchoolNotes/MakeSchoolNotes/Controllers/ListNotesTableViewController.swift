//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListNotesTableViewCell
        cell.noteTitleLabel.text = "note's title"
        cell.noteModificationTimeLabel.text = "note's modification time"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       //1 
        if let identifier = segue.identifier {
            //2
            if identifier == "displayNote"{
                //3 
                print("Table view cell tapped")
            } else if identifier == "addNote" {
                print(" + button tapped")
            }
        }
    }
    
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
    }
}