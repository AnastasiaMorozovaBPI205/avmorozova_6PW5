//
//  ArticleManager.swift
//  avmorozova_6PW5
//
//  Created by Anastasia on 09.11.2021.
//

import UIKit

class ArticleManager {
    var renewingDelegate: RenewingDelegate?
    
    var articlePage: ArticlePage?
    
    private var articles: [ArticleModel]? {
        didSet {
            renewingDelegate?.renew()
        }
    }
    
    public var Articles: [ArticleModel]? {
        get {
            return articles
        }
        
        set (array) {
            articles = array
        }
    }
    
    func getNewArticles() {
        fetchNews()
    }
    
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    
    private func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data,
                                                            response, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                var articlePage = try?
                    JSONDecoder().decode(ArticlePage.self, from: data)
                
                articlePage?.passTheRequestId()
                
                self?.articles = articlePage?.news
            }
        }.resume()
    }
}
