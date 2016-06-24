//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Kenny Batista on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

//realm helper class
class RealmHelper {
    //static methods will go here
    //with static methods, we don't have to instantiate the class
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
 
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    static func retrieveNote() {
        let realm = try! Realm()
        realm.objects(Note).sorted("modificationTime", ascending: false)
    }
}




