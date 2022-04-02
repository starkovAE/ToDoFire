//
//  TaskViewController.swift
//  ToDoFire
//
//  Created by Александр Старков on 02.04.2022.
//

import UIKit

class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
    }
    
} //закрывает класс

//MARK: - Extension for VC
extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text =  "This is cell number \(indexPath.row)"
        cell.textLabel?.textColor = .black
        return cell
    }
    
    
}
