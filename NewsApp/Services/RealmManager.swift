//
//  RealmManager.swift
//  NewsApp
//
//  Created by Алексей Орловский on 03.06.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm
    
    private init() {
        do {
            let config = Realm.Configuration(
                schemaVersion: 2,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 2 {
                        migration.enumerateObjects(ofType: NewsItem.className()) { oldObject, newObject in
                            newObject?["url"] = ""
                            newObject?["imageData"] = Data()
                        }
                    }
                })
            realm = try Realm(configuration: config)
        } catch {
            fatalError("Ошибка при инициализации Realm: \(error)")
        }
    }
    
    func saveNewsItem(_ item: NewsItem) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func updateNewsItem(_ item: NewsItem, withImageData imageData: Data) {
        try! realm.write {
            item.imageData = imageData
        }
    }
    
    func getSavedNewsItems() -> Results<NewsItem> {
        return realm.objects(NewsItem.self)
    }
    
    func deleteNewsItem(_ item: NewsItem) {
        try! realm.write {
            realm.delete(item)
        }
    }
}
