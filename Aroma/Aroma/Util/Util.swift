//
//  Util.swift
//  Aroma
//
//  Created by Vishnu Divakar on 6/30/20.
//  Copyright © 2020 Vishnu Divakar. All rights reserved.
//

import Foundation
import Firebase

struct Util {
    static func getUsername(completionHandler: @escaping (_ username: String) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constants.FireBase.userModelCollectionName).whereField(Constants.UserModel.userId, isEqualTo: Auth.auth().currentUser?.uid ?? "")
            .getDocuments { (snapshot, error) in
                if error == nil {
                    let value = (snapshot?.documents.first?.data() ?? nil)
                    if value != nil {
                        completionHandler(value![Constants.UserModel.name] as! String)
                    }
                }
        }
    }
}
