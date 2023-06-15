//
//  ViewController.swift
//  Project2
//
//  Created by Fauzan Dwi Prasetyo on 19/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var tap = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.contentVerticalAlignment = .fill
        button1.contentHorizontalAlignment = .fill
       

        
        askQuestion()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetScore))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: .none, action: .none)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()


        button1.setImage(UIImage(named: countries[0])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button2.setImage(UIImage(named: countries[1])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button3.setImage(UIImage(named: countries[2])?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        tap += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: .none, action: .none)
        
        var msg = "Your score is \(score)"
        if tap == 10 {
            msg = "Your final score is \(score)"
        }
        
        let ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
        if tap == 10 {
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        }
    }
    
    @objc func resetScore() {
        score = 0
        tap = 0
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: .none, action: .none)
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
    }
}

