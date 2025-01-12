//
//  SearchVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let networkManager: NetworkManagerProtocol
    
    private var searchController: UISearchController!
    private var tableView = UITableView()
    
    private var labelWhenEventIsEmpty = UILabel.setupLabel(with: .boldSystemFont(ofSize: 18), tintColor: .black, line: 3)
    private var imageWhenEventIsEmpty = UIImageView()
    private var stackView = UIStackView()
    
    var searchedElement: [SearchResultModel] = []
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSearchBar ()
        configureTableView()
        setupBackgroundElement()
        
        
    }
    
    
    func search(text: String) {
        networkManager.getSearch(search: text) { [weak self] (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.searchedElement = value.results
                    value.results.isEmpty ? self?.emptyResult() : self?.noEmptyResult()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup UI
private extension SearchVC {
    
    func setupSearchBar () {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Введите что-то"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func emptyResult() {
        stackView.isHidden = false
        imageWhenEventIsEmpty.image = UIImage(named: "panda")
        labelWhenEventIsEmpty.text = "Упсс.. по вашему запросу мы ничего не нашли.\nНо у нас  всегда есть панда)"
    }
    
    func noEmptyResult() {
        stackView.isHidden = true
        imageWhenEventIsEmpty.image = UIImage(named: "loupe")
        labelWhenEventIsEmpty.text = "Ищите интересные места\nв вашем городе"
    }
    
    func setupBackgroundElement() {
        imageWhenEventIsEmpty.contentMode = .scaleAspectFit
        imageWhenEventIsEmpty.clipsToBounds = true
        imageWhenEventIsEmpty.image = UIImage(named: "loupe")
        
        labelWhenEventIsEmpty.textAlignment = .center
        labelWhenEventIsEmpty.text = "Ищите интересные места\nв вашем городе"
        
        stackView.addArrangedSubview(imageWhenEventIsEmpty)
        stackView.addArrangedSubview(labelWhenEventIsEmpty)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        tableView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        tableView.tableFooterView = UIView()
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseId)
        tableView.rowHeight = 150
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 10
        
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedElement.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseId, for: indexPath) as! SearchCell
        let element = searchedElement[indexPath.row]
        cell.isUserInteractionEnabled = false
        cell.set(event: element)
        return cell
    }
}



// MARK: - SearchBar delegate
extension SearchVC: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        search(text: text)
        dismiss(animated: true, completion: nil)
    }
    
    
}
