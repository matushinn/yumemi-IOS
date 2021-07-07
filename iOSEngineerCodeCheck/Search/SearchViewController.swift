//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import APIKit
import SwiftUI


protocol SearchView: class {
    func updateTableView()
    func showAlert(with errorMessage: String)
}

class SearchViewController: UITableViewController, StoryboardInstantiatable, Injectable {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "リポジトリを検索"
            searchBar.delegate = self
        }
    }
     
    var presenter: SearchPresenter!
    func inject(_ dependency: SearchPresenter) {
        self.presenter = dependency
        self.presenter.view = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    /// - Note: To avoid scroll to top when pop viewController
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.isScrollEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        tableView.isScrollEnabled = false
    }
    
    private func setupTableView() {
        tableView.register(cellType: RepositoryCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 134
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: RepositoryCell.self, for: indexPath)
        let repository = presenter.repositories[indexPath.item]
        cell.configure(repository: repository)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = presenter.repositories[indexPath.item]
        let detailVC = UIHostingController(rootView: DetailView(repository: repository))
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxScrollDistance = max(0, scrollView.contentSize.height - scrollView.bounds.size.height)
        presenter.setIsReachedBottom(maxScrollDistance <= scrollView.contentOffset.y)
    }
}

extension SearchViewController: SearchView {
    func updateTableView() {
        self.tableView.reloadData()
    }
    
    func showAlert(with errorMessage: String) {
        let alert = UIAlertController(title: errorMessage,
                                              message: errorMessage,
                                              preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.textDidChange()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchButtonTapped(with: text)
    }
}
