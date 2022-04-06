//
//  User.swift
//  ToDoFire
//
//  Created by Александр Старков on 03.04.2022.
//

import Foundation
import Firebase

struct AppUser {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
