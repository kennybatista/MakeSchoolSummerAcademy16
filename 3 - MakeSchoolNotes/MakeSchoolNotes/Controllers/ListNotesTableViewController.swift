//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    

    
    //the table view is now aware that the populated lists table exists
    //also, this is an array with all of the notes contained. we can tell numberOfRowsInSection that we want these amount of notes for the amount of cells
    
    var notes : Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNotes()
    self.tableView.backgroundColor = UIColor.blackColor()
    
    
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
  
    //MARK: cellForRow
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListNotesTableViewCell
        
        //we store the current note/modification/time/content in this constant
        let note = notes[indexPath.row]
        
        //on the table cell, we add the note's title from the notes models
        cell.noteTitleLabel.text = note.title
        
        //on the table cell, we add the note's modification time from the notes models + we convert the time into a string
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        cell.notePreviewLabel.text = note.content
        
        //Styels
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        cell.backgroundColor = UIColorFromRGB(0x34495e)
        
        
        //we return the cell so that it could be displayed to the table view
        
        
        
        
        
////        let whiteRoundedView : UIView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 20, 149))
//        
//        cellView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.8])
//        cellView.layer.masksToBounds = false
//        cellView.layer.cornerRadius = 2.0
//        cellView.layer.shadowOffset = CGSizeMake(-1, 1)
//        cellView.layer.shadowOpacity = 0.2
//        
//        cell.contentView.addSubview(cellView)
//        cell.contentView.sendSubviewToBack(cellView)
        
        
        return cell
    }
    
    
    
    
    
    
//   override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 140.0
//    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.contentView.backgroundColor = UIColor.darkGrayColor()
        
        
      
        
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
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retrieveNotes()
            //4
            tableView.reloadData()
        }
    }
}