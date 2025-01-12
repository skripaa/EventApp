//
//  ChooseCategory.swift
//  EventApp 1
//
//  Created by Vova SKR on 08/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

protocol SelectCategoryVCDelegate: class {
    func setCategory(data: Categories)
}

class SelectCategoryVC: UIViewController {
    
    var categoriesModel: [Categories] = [.all,.concert,.festival,.standUp,.theater]
    var currentCategory: Categories?
    
    private var tableView = UITableView()
    weak var delegate: SelectCategoryVCDelegate?
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar() 
        configureTableView()
        
    }
    
    func setup(currentCategories: Categories, title: String?) {
        self.currentCategory = currentCategories
        self.title = title
    }
    
    @objc
    func rightButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: - Setup UI
private extension SelectCategoryVC {
    
    func setupTabBar() {
        var rightBarItem: UIBarButtonItem!
        if #available(iOS 13.0, *) {
            rightBarItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(rightButtonPressed))
        } else {
            rightBarItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(rightButtonPressed))
        }
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ChooseCategoryCell")
        tableView.rowHeight = 50
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

// MARK: - TableView Delegate, DataSourse

extension SelectCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categoriesModel[indexPath.row].nameCategory
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectCategory = categoriesModel[indexPath.row]
        if selectCategory != currentCategory {
           self.delegate?.setCategory(data: categoriesModel[indexPath.row])
        }
        dismiss(animated: true, completion: nil)
    }
}



