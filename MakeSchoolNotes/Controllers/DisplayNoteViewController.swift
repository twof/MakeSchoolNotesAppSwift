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
    @IBOutlet var noteContentTextView: UITextView!
    @IBOutlet var noteTitleTextField: UITextField!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            if let note = note {
                let newNote = Note()
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                print(noteTitleTextField.text)
                print(noteContentTextView.text)
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                // if note does not exist, create new note
                let note = Note()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                print(noteTitleTextField.text)
                print(noteContentTextView.text)
                print(note.title)
                print(note.content)
                note.modificationTime = NSDate()
                // 2
                RealmHelper.addNote(note)
            }
            // 3
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
}
