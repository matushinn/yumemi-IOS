//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController,StoryboardInstantiatable {

    @IBOutlet weak var searchBar: UISearchBar!
    
    //private var items: [Item] = []
    
    var items: [[String: Any]]=[]
    private var task: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        task?.resume()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        /*
        let detailVC = DetailViewController.instantiate(with: items[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
 */
    }
    
}
