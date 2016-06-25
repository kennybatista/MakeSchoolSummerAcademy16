//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Kenny Batista on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

//** Static: these are methods in our class, when we put the static keyword behind those methods it turns them into local methods for the whole class, that way we won't have to create an instance of the class before calling the method.

//var notes: Results<Note>!

//realm helper class
class RealmHelper {
    //static methods will go here
    //with static methods, we don't have to instantiate the class
    //"try" itself means that there might be a problem when retriving realm, "try!" means that it will try to retrive realm and that it knows that there are no problems
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    //helper method
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
 
    }
    
    //helper method
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    //helper method
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: true)
        
    }
}




