//
//  ViewController.swift
//  avmorozova_6PW5
//
//  Created by Anastasia on 09.11.2021.
//

import UIKit

class ArticleViewController: UIViewController {
    
    private var tableView: UITableView?
    private var articleManager: ArticleManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.register(ArticleTableViewCell.self, forCellReuseIdentifier: "articleCell")
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articleCount = articleManager?.Articles?.count else { return 0 }
        
        return articleCount
    }

    func numberOfSections(in tableView: UITableView) -> Int { 1 }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "articleCell",
            for: indexPath
        ) as? ArticleTableViewCell

        return cell ?? UITableViewCell()
    }
}
