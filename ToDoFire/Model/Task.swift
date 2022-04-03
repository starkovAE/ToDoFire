//
//  Task.swift
//  ToDoFire
//
//  Created by Александр Старков on 03.04.2022.
//

import Foundation
import Firebase
struct Task {
    let title: String
    let userId: String
    let ref: DatabaseReference? //эта ссылка на данные (точная ссылка на объект в базу данных)
    var completed: Bool = false
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    init(snapshot: DataSnapshot) { //когда мы храним данные в базе данных и хотим получить текщуее значение этих данных мы получаем некий snapshot (снимок, срез данных) получаем фотку наших данных и эта фотка содержит всю информацию о наших данных на этот момент (это и есть JSON)
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
