//
//  DatabaseManager.swift
//  ChatApp
//
//  Created by Joshua Sturgell on 7/10/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK - Account Management

extension DatabaseManager {
    
    /// Test to see if user exists
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func registerUser(with user: ChatAppUser) {
        database.child(user.emailAddress).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureURL: String
}


