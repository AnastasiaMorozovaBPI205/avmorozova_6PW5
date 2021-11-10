//
//  ArticlePage.swift
//  avmorozova_6PW5
//
//  Created by Anastasia on 10.11.2021.
//

import UIKit

struct ArticlePage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    
    mutating func passTheRequestId() {
        for i in 0..<(news?.count ?? 0) {
            news?[i].requestId = requestId
        }
    }
}
