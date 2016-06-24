//
//  Notes.swift
//  MakeSchoolNotes
//
//  Created by Kenny Batista on 6/23/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class Note : Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
    
    // we do this to store our new notes data in here, our table view is currently displaying hard coded values. If we want it to prepare for displaying populated data, we have to tell it to that this models exists. go to the ListNotesTableViewController and add var notes : [Notes]()
}
