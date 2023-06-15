//
//  ViewController.swift
//  Project46
//
//  Created by Fauzan Dwi Prasetyo on 29/04/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadProduct))
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProduct))
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareProduct))
        
        navigationItem.rightBarButtonItems = [shareBarButton, addBarButton]
    }
    
    @objc func reloadProduct() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func addProduct() {
        let ac = UIAlertController(title: "Add Product Name", message: "ex: iPhone, Laptop, etc", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let newProduct = ac?.textFields?[0].text else { return }
            self?.submit(newProduct)
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
    }
    
    func submit(_ newProduct: String) {
        var errorTitle: String
        var errorMessage: String

        if isReal(newProduct) {
            shoppingList.append(newProduct)
            
            let indexPath = IndexPath(row: shoppingList.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            errorTitle = "Product not recognised"
            errorMessage = "You can't just make them up, you know!"
            
            let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(ac, animated: true)
        }
    }
    
    func isReal(_ newProduct: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: newProduct.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: newProduct, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    @objc func shareProduct() {
        let allProducts = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [allProducts], applicationActivities: [])
        present(vc, animated: true)
    }


}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
}
