//
//  TaskViewController.swift
//  ToDoFire
//
//  Created by Александр Старков on 02.04.2022.
//

import UIKit
import Firebase
class TaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) { //когда мы нажимаем на эту кнопку мы хотим, чтобы мы вышли из данного профиля
        do {
           try Auth.auth().signOut() //у этого метода есть маркировка throws (поэтому он используется в do catch)
        } catch {
            print(error.localizedDescription)
        }
        //закрываем этот экран
       dismiss(animated: true, completion: nil)
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
