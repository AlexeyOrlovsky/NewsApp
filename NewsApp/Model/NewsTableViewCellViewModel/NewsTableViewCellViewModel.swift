//
//  NewsTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Алексей Орловский on 23.05.2023.
//

import Foundation
import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    var publishedAt: String?
    var url: String?
    var content: String?
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?,
        publishedAt: String?,
        url: String?,
        content: String?
    ){
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.url = url
        self.content = content
    }
}
