//
//  SearchCell.swift
//  EventApp 1
//
//  Created by Vova SKR on 08/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    static let reuseId = "searchCell"
    
    var customView = UIView()
    
     let headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 18), tintColor: .black, line: 2)
     let bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 14), tintColor: .gray, line: 3)
    private let addressLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .darkGray, line: 1)
    private var stackView: UIStackView!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCustomView()
        setupStackView()
        setupLayoutConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(event: SearchResultModel) {
        headerLabel.text = event.title ?? "Название"
        bodyLabel.text = event.description ?? "Описание"
        addressLabel.text = "Адресс - \(String(describing: event.address ?? "Москва"))"
      
    }
    
}

// MARK: - Setup UI

private extension SearchCell {
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [headerLabel,bodyLabel, addressLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        customView.addSubview(stackView)
    }
    
    func setupCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
    }
    
   
    
    func setupLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -15)
        ])
    }
}
