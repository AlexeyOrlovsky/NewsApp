//
//  NewsItem.swift
//  NewsApp
//
//  Created by Алексей Орловский on 03.06.2023.
//

import Foundation
import RealmSwift

class NewsItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionText: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var imageData: Data? = nil
}

