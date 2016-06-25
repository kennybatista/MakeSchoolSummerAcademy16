//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    var note: Note?

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //1
        //if let note = note ; this is optional binding
        if let note = note {
            noteContentTextView.text = note.content
            noteTitleTextField.text = note.title
        } else {
            //3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
       
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            //in note, store the notes data if there it's available
            if let note = note {
                let newNote = Note()
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                //2
                RealmHelper.updateNote(note, newNote: newNote)
            } else { //if note does note exist, create a new one
                
                //an instance of the Note model
                let note = Note()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                //we store the current date in the newNote model
                note.modificationTime = NSDate()
                //here we add all of the above modification(empty text field, title field, set nsdate) to the table view listing all notes
                RealmHelper.addNote(note)
            }
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }
    
    

}
