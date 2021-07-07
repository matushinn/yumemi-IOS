//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit
import Nuke

class DetailViewController: UIViewController, StoryboardInstantiatable, Injectable {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    private var repository: Repository!
    
    func inject(_ dependency: Repository) {
        self.repository = dependency
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(repository: repository)
    }
    
    private func configure(repository: Repository) {
        languageLabel.text = repository.language.map { "Written in \($0)" }
        starsCountLabel.text = "\(repository.stargazersCount) stars"
        watchersCountLabel.text = "\(repository.watchersCount) watchers"
        forksCountLabel.text = "\(repository.forksCount) forks"
        issuesCountLabel.text = "\(repository.openIssuesCount) open issues"
        titleLabel.text = repository.fullName
        
        guard let url = URL(string: repository.owner.avatarUrl) else { return }
        Nuke.loadImage(with: url, into: profileImageView)
    }
}
