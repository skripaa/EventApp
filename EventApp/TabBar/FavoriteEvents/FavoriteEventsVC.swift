//
//  FavoriteEventsVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class FavoriteEventsVC: UIViewController {
    
    var networkManager: NetworkManagerProtocol
    var storageService: StorageServiceProtocol
    
    private var tableView = UITableView()
    
    private var labelWhenEventIsEmpty = UILabel.setupLabel(with: .boldSystemFont(ofSize: 18), tintColor: .black, line: 2)
    private var imageWhenEventIsEmpty = UIImageView()
    private var stackView = UIStackView()
    
    var eventsList: [EventModel] {
        
        storageService.getSavedEvents()
    }
    
    
    // MARK: - Init
    init(networkManager: NetworkManagerProtocol,
         storageService: StorageServiceProtocol) {
        
        self.networkManager = networkManager
        self.storageService = storageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupBackgroundElement()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideTableViewIfNeeded()
    }
    
    private func hideTableViewIfNeeded() {
        
        if eventsList.isEmpty {
            tableView.isHidden = true
            stackView.isHidden = false
        } else {
            tableView.isHidden = false
            stackView.isHidden = true
            tableView.reloadData()
        }
    }
}

// MARK: - Setup UI
private extension FavoriteEventsVC {
    
    func setupBackgroundElement() {
//        imageWhenEventIsEmpty.frame.size = CGSize(width: 200, height: 200)
        imageWhenEventIsEmpty.contentMode = .scaleAspectFit
        imageWhenEventIsEmpty.clipsToBounds = true
        imageWhenEventIsEmpty.image = UIImage(named: "heartBig")
        
        labelWhenEventIsEmpty.textAlignment = .center
        labelWhenEventIsEmpty.text = "Сохраняйте события,\nкоторые вам нравятся"
        
        stackView.addArrangedSubview(imageWhenEventIsEmpty)
        stackView.addArrangedSubview(labelWhenEventIsEmpty)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        //        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTableView() {
        setupTableView()
        setTableViewDelegates()
        tableView.tableFooterView = UIView()
        tableView.register(FavoriteEventsCell.self, forCellReuseIdentifier: FavoriteEventsCell.reuseId)
        tableView.rowHeight = 110
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

extension FavoriteEventsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = FavoriteEventsCell.reuseId
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FavoriteEventsCell else {
            return UITableViewCell()
        }
        
        let event = eventsList[indexPath.row]
        cell.set(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailEvent = DetailEventVC(event: eventsList[indexPath.row],
                                        networkManager: networkManager,
                                        storageService: storageService)
        
        detailEvent.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(detailEvent, animated: true)
    }
}
