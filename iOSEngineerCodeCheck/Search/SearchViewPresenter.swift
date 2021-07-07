//
//  SearchViewPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

protocol SearchPresenter {
    var view: SearchView? { get set }
    var repositories: [Repository] { get }
    func searchButtonTapped(with text: String)
    func textDidChange()
    func setIsReachedBottom(_ isReachedBottom: Bool)
}

class SearchViewPresenter: SearchPresenter {
    
    weak var view: SearchView?
    var repositories: [Repository] {
        return model.repositories
    }
    private var model: SearchModelProtocol
    private var isReachedBottom: Bool = false
    
    init(model: SearchModelProtocol) {
        self.model = model
        self.model.delegate = self
    }
    
    func searchButtonTapped(with query: String) {
        guard query.count != 0 else { return }
        model.fetchInitialRepositories(query: query)
    }
    
    func textDidChange() {
        model.cancel()
    }
    
    func setIsReachedBottom(_ isReachedBottom: Bool) {
        if !self.isReachedBottom && isReachedBottom {
            model.fetchAdditionalRepositories()
        }
        self.isReachedBottom = isReachedBottom
    }
}

extension SearchViewPresenter: SearchModelDelegate {
    func didChange(repositories: [Repository]) {
        DispatchQueue.main.async {
            self.view?.updateTableView()
        }
    }
    
    func didReceive(error: SessionTaskError) {
        DispatchQueue.main.async {
            //TODO: change error message
            self.view?.showAlert(with: error.localizedDescription)
        }
    }
}
