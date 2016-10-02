//
//  User.swift
//  alarm
//
//  Created by edmund on 10/1/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import Foundation

class User {
    var name: String?
    var email: String?
    var uid: String?
    var accessToken: String?
    
    init(name: String, email: String, uid: String, accessToken: String) {
        self.name = name
        self.email = email
        self.uid = uid
        self.accessToken = accessToken
    }
    
    func toDict() -> [String: AnyObject] {
        return [
            "name": name!,
            "email": email!,
            "oauth_identities": [
                "uid": uid!,
                "access_token": accessToken!
            ]
        ]
    }
}