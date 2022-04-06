//
//  ViewController.swift
//  ToDoFire
//
//  Created by Александр Старков on 02.04.2022.
//

import UIKit
import Firebase
class ViewController: UIViewController {
let segueIdentifier = "tasksSegue"
    var ref: DatabaseReference!
    
    @IBOutlet weak var warnLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        //Создаем наблюдателей для клавы
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        //Делаем warnLabel прозрачным
        warnLabel.alpha = 0
        //метод addStateDidChangeListener позволяет проверить изменился ли пользователь и его данные
        Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        })
    }
    //MARK: - viewWillAppear
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          emailTF.text = ""
          passwordTF.text = ""
      }
      
//MARK: - методы для клавиатуры:
    @objc private func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //получаем размеры клавы, кастим в NSValue и достаем CGRect - так в документации написано

        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0) //для индикатора, чтобы ниже клавы не уходил

    }
    @objc private func kbDidHide(notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    //MARK: - метод для полявления warningLabel
    private func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    //MARK: - loginTapped
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return }
             
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if error !=  nil { //ошибка не равна нил? Значит, ошибка существует
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil { //пользователь не равен нил (то есть пользователь сущесвует)
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user") //если вообще пользователя нет
        }
    }
    
 //MARK: - registerTapped
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != ""
        else {
            displayWarningLabel(withText: "Info is incorrect")
            return
            
        }
        Auth.auth().createUser(withEmail: email, password: password, completion:  { [weak self] authResult, error
            in
            guard error == nil, let user = authResult?.user  else {
                print(error!.localizedDescription)
                return
            }
            let userRef = self?.ref.child(user.uid)
            userRef?.setValue(user.email, forKey: "email")
        })
        
        
    }
}

