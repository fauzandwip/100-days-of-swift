//
//  DetailViewController.swift
//  Project19-21
//
//  Created by Fauzan Dwi Prasetyo on 12/05/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    var defaults = UserDefaults.standard
    var notes: [Note]?
    var note: Note?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard notes != nil else { return }
        if let note {
            notes?.insert(note, at: 0)
        }
        
        saveData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitleField.delegate = self
        noteTextView.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        
        if let note {
            noteTitleField.text = note.noteTitle
            noteTextView.text = note.noteText
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let deleteNoteButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteNote)
        )
        let saveNoteButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveNote)
        )
        
        toolbarItems = [spacer, saveNoteButton, deleteNoteButton, spacer]
        navigationController?.toolbar.tintColor = .black
    }
    
    @objc func shareNote() {
        if let note {
            let activityVC = UIActivityViewController(activityItems: [note.noteTitle, note.noteText], applicationActivities: nil)
            present(activityVC, animated: true)
        }
    }
    
    @objc func saveNote() {
        saveData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func deleteNote() {
        note = nil
        saveData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let savedData = try jsonEncoder.encode(notes)
            defaults.set(savedData, forKey: "notes")
        } catch {
            print("Failed to save data, \(error)")
        }
        
    }
    
}


// MARK: - UITextFieldDelegate & UITextViewDelegate Method
extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard note != nil else { return }
        
        note?.noteTitle = noteTitleField.text ?? ""
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard note != nil else { return }
        
        note?.noteText = noteTextView.text ?? ""
    }
}
