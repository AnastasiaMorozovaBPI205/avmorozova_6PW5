//
//  ViewController.swift
//  avmorozova_6PW5
//
//  Created by Anastasia on 09.11.2021.
//

import UIKit

protocol RenewingDelegate {
    func renew () -> ()
}

class ArticleViewController: UIViewController {
    
    private var tableView: UITableView?
    private var articleManager: ArticleManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        articleManager = ArticleManager()
        articleManager?.getNewArticles()
        articleManager?.renewingDelegate = self
    }
    
    private func setupTableView() {
        let table = UITableView(frame: .zero, style: UITableView.Style.plain)
        view.addSubview(table)
        
        table.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        table.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        table.pin(to: view, .left, .right)
        
        table.backgroundColor = .white
        
        tableView = table
        
        tableView?.register(ArticleTableViewCell.self, forCellReuseIdentifier: "articleCell")
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleManager?.Articles?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "articleCell",
            for: indexPath
        ) as? ArticleTableViewCell
        
        let article = articleManager?.Articles?[indexPath.row]
        
        cell?.setupArticleCell(title: article?.title,description: article?.announce, url: article?.img?.url)
                
        return cell ?? UITableViewCell()
    }
}

extension ArticleViewController: RenewingDelegate {
    func renew() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
