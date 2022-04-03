//
//  ViewController.swift
//  ToDoFire
//
//  Created by Александр Старков on 02.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var warnLabel: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
        
    }
//MARK: - методы для клавиатуры:
//    @objc private func kbDidShow(notification: Notification) {
//        guard let userInfo = notification.userInfo else { return }
//        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue //получаем размеры клавы, кастим в NSValue и достаем CGRect - так в документации написано
//
//        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
//        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0) //для индикатора, чтобы ниже клавы не уходил
//
//    }
//    @objc private func kbDidHide(notification: Notification) {
//        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
//    }
    @objc private func updateView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if notification.name == UIResponder.keyboardDidHideNotification {
            (self.view as! UIScrollView).contentInset = UIEdgeInsets.zero
        } else {
            (self.view as! UIScrollView).contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height +  self.view.bounds.size.height, right: 0)
            (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        }
//        (self.view as! UIScrollView).scrollsToTop = true
    }
//

    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
    }
}

