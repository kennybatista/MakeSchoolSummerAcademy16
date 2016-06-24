//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    

    
    
    //the table view is now aware that the populated lists table exists
    //also, this is an array with all of the notes contained. we can tell numberOfRowsInSection that we want these amount of notes for the amount of cells
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListNotesTableViewCell
        
        //we store the current note/modification/time/content in this constant
        let note = notes[indexPath.row]
        
        //on the table cell, we add the note's title from the notes models
        cell.noteTitleLabel.text = note.title
        
        //on the table cell, we add the note's modification time from the notes models + we convert the time into a string
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        //we return the cell so that it could be displayed to the table view
        return cell
    }
    
    //here we prepare before transitioning to the next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       //1 
        if let identifier = segue.identifier {
            //2
            if identifier == "displayNote"{
                //3 
                print("Table view cell tapped")
                // every tableview has a property called indexPathForSelectedRow, which returns the current path, or nil if there is nothing. But in our case, we've got a note, so it's not nil
                
                let indexPath = tableView.indexPathForSelectedRow!
                
                let note = notes[indexPath.row]
                
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                
                displayNoteViewController.note = note
            } else if identifier == "addNote" {
                print(" + button tapped")
            }
        }
    }
    
    //here we set an unwind segue, where we transition from a different view to the ListNotesTableViewController
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //3
            notes.removeAtIndex(indexPath.row)
            //4
            tableView.reloadData()
        }
    }
}