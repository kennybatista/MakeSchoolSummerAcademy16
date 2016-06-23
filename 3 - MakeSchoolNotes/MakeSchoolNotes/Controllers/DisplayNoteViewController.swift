//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    override func viewWillAppear(animated: Bool) {
        //1
        noteContentTextView.text = "l"
        noteTitleTextField.text = "l"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            //2
            if identifier == "Cancel" {
                print("Cancel button tapped")
                
            } else if identifier == "Save" {
                print("Save button tapped")
            }
        }
        
        
        //1 - Instance of note : call the note model object, the one containing all of the notes
        let note = Note()
        
        //2 - if the textfield has a value, the value of the expression will be that value. If the textfield is empty, then we give it the value after the ??, which is ??
        note.title = noteTitleTextField.text ?? ""
        note.content = noteContentTextView.text ?? ""
        
        //3
        //we store the current date/time in the model
        note.modificationTime = NSDate()
        
        
        //**SAVING NOTE **
        //1
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        listNotesTableViewController.notes.append(note)
    }
    
    

}
