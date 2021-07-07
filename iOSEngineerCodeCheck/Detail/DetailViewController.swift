//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,StoryboardInstantiatable,Injectable {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    
    //var item: Item!
/*
    func inject(_ dependency: Item) {
            self.item = dependency
    }

 */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //configure(item: item)
        
    }
    

    

}
