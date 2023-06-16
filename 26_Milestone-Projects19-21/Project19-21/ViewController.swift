//
//  ViewController.swift
//  Project19-21
//
//  Created by Fauzan Dwi Prasetyo on 12/05/23.
//

import UIKit

class ViewController: UITableViewController {

    var notes = [Note]()
    var defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isToolbarHidden = true
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        loadData()
        
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.notes = notes
            vc.note = Note(noteTitle: "Title", noteText: "Write note text here", lastEdit: Date.now)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func loadData() {
        if let savedData = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                self.notes = try jsonDecoder.decode([Note].self, from: savedData)
            } catch {
                print("Failed to load data, \(error)")
            }
            
        }
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
    
    @objc func loadList() {
        loadData()
        self.tableView.reloadData()
    }
    
}


// MARK: - UITableViewController Method

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = note.noteTitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cell.detailTextLabel?.text = note.noteText
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            notes.remove(at: indexPath.row)

            vc.notes = notes
            vc.note = note
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
