//
//  ViewController.swift
//  Project7-9
//
//  Created by Fauzan Dwi Prasetyo on 02/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    var currentAnswer: UILabel!
    var submitButton: UIButton!
    var arrayData = [String]()
    var usedLetters = [String]()
    
    var life = 8 {
        didSet {
            title = "Life: \(life)"
        }
    }
    
    var score = 0 {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)")
        }
    }
    
    var word = "RHYTHM" {
        didSet {
            DispatchQueue.main.async {
                self.currentAnswer.text! = String(repeating: "?", count: self.word.count)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Life: \(life)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reset))
        
        currentAnswer = UILabel()
        currentAnswer.text = "????????"
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: 36)
        currentAnswer.numberOfLines = 1
        view.addSubview(currentAnswer)
        
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Guess", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.titleLabel?.numberOfLines = 1
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        submitButton.layer.cornerRadius = 20
        submitButton.addTarget(self, action: #selector(guessButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            // currentAnswer
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // submitButton
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: currentAnswer.centerXAnchor)
        ])
           
        performSelector(inBackground: #selector(loadData), with: nil)
    }
    
    @objc func loadData() {
        if let urlString = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let data = try? String(contentsOf: urlString) {
                arrayData = data.components(separatedBy: "\n")
                word = arrayData[0].uppercased()
            }
        }
    }
    
    @objc func guessButtonTapped() {
        let ac = UIAlertController(title: "Type 1 Letter", message: "Can't more than 1 letter", preferredStyle: .alert)
        ac.addTextField()
        
        let submitButton = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let letter = ac?.textFields?[0].text else { return }
            if !(letter.count == 1) {
                self?.showError()
            } else {
                self?.answer(letter.uppercased())
            }
        }
        ac.addAction(submitButton)
        
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Invalid", message: "You should only type 1 letter!", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            self?.guessButtonTapped()
        }
        ac.addAction(okButton)
        
        present(ac, animated: true)
    }
    
    func answer(_ lett: String) {
        currentAnswer.text = ""
        usedLetters.append(lett)
        
        life -= 1
        if life == 0 {
            lose()
        }
        
        for letter in word {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                currentAnswer.text! += strLetter
            } else {
                currentAnswer.text! += "?"
            }
        }
        
        if currentAnswer.text == word {
            usedLetters.removeAll(keepingCapacity: true)
            rightAnswer()
            
            arrayData.shuffle()
            word = arrayData[0].uppercased()
            life = 8
            score += 1
        }
    }
 
    func rightAnswer() {
        let ac = UIAlertController(title: "Good", message: "Your answer is correct, \(word.uppercased())", preferredStyle: .alert)
        
        let nextButton = UIAlertAction(title: "Next", style: .default)
        ac.addAction(nextButton)
        
        present(ac, animated: true)
    }
    
    func lose() {
        let ac = UIAlertController(title: "You Lose", message: "Right answer is : \(word)", preferredStyle: .alert)
        
        let tryAgainButton = UIAlertAction(title: "Try Again", style: .default) { [weak self] action in
            self?.reset()
        }
        ac.addAction(tryAgainButton)
        
        present(ac, animated: true)
    }
    
    @objc func reset() {
        arrayData.shuffle()
        word = arrayData[0].uppercased()
        
        usedLetters.removeAll(keepingCapacity: true)
        score = 0
        life = 8
    }
}

