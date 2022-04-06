//
//  TaskViewController.swift
//  ToDoFire
//
//  Created by Александр Старков on 02.04.2022.
//

import UIKit
import Firebase
class TaskViewController: UIViewController {

    var user: AppUser! //создали пользователя
    var ref: DatabaseReference!
    var task = Array<Task>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //текущий пользователь
        guard let currentUser = Auth.auth().currentUser else { return } //если получается получить текущего пользователя
        user = AppUser(user: currentUser)
        //путь - ссылка на место
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            let task = Task(title: textField.text!, userId: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())//используем заголовок (имя) задачи для название папки (ссылки)
            //помещаем по адресу taskRef задачу task
            taskRef?.setValue(task.convertToDictionary())
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
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
