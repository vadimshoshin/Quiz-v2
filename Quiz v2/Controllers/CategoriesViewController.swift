//
//  CategoriesViewController.swift
//  Quiz v2
//
//  Created by Vadim Shoshin on 01.12.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.instance.loadCategories()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    private func getCategory(for indexPath: IndexPath) -> Category {
        guard let categoryToLoad = DataManager.instance.getCategory(indexPath: indexPath) else {fatalError("Category with wrong indexPath")}
        return categoryToLoad
    }

}

// MARK: - TableView extensions

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { fatalError("Cell with wrong identifier") }
        
        let category = getCategory(for: indexPath)
        cell.update(category)
        tableView.reloadData()
        return cell
    }
}