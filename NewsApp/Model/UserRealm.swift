//
//  User.swift
//  NewsAppTest
//
//  Created by Алексей Орловский on 08.06.2023.
//

import RealmSwift

class User: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
}
