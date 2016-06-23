//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
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
    }

}
