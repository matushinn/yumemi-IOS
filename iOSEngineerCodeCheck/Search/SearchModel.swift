//
//  SearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import APIKit

protocol SearchModelProtocol {
    var delegate: SearchModelDelegate? { get set }
    var repositories: [Repository] { get }
    var sessionTask: SessionTask? { get }
    func fetchAdditionalRepositories()
    func fetchInitialRepositories(query: String)
    func cancel()
}

class SearchModel: SearchModelProtocol {
    weak var delegate: SearchModelDelegate?
    internal var sessionTask: SessionTask?
    private var currentPage: Int = 1
    private var currentQuery: String = ""
    
    private(set) var repositories: [Repository] = [] {
        didSet {
            if oldValue != repositories {
                self.delegate?.didChange(repositories: repositories)
            }
        }
    }
    
    func fetchAdditionalRepositories() {
        fetchRepositories(query: self.currentQuery, page: currentPage + 1) { [weak self] (response) in
            self?.repositories += response.repositories
        }
    }
    
    func fetchInitialRepositories(query: String) {
        self.currentQuery = query
        self.currentPage = 1
        fetchRepositories(query: query, page: self.currentPage) { [weak self] response in
            self?.repositories = response.repositories
        }
    }
    
    private func fetchRepositories(query: String, page: Int, completion: @escaping (SearchResponse) -> Void) {
        let request = GitHubAPI.SearchRepositories(query: query, page: page)
        self.sessionTask = GitHubAPI.call(request: request) { [weak self] (result) in
            switch result {
            case let.success(response):
                self?.currentPage += 1
                completion(response)
            case let .failure(error):
                self?.delegate?.didReceive(error: error)
            }
        }
    }
    
    func cancel() {
        sessionTask?.cancel()
    }
}

protocol SearchModelDelegate: class {
    func didChange(repositories: [Repository])
    func didReceive(error: SessionTaskError)
}
