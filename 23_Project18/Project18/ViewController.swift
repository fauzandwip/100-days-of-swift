//
//  ViewController.swift
//  Project18
//
//  Created by Fauzan Dwi Prasetyo on 10/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm inside the viewDidLoad() method!")
        print(1, 2, 3, 4, 5)
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        print("Some message", "Some msg", "Some msg")

        // fn + f6 to next line
        // cmd + ctrl + y to next breakpoint
        for i in 1...100 {
            print("Got number \(i)")
        }
        
        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
        
        assert(1 == 2, "Maths failure!")
        assert(1 == 1, "Maths failure!")
    }
    
    func myReallySlowMethod() -> Bool {
        return false
    }


}

