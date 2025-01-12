//
//  WelcomeCell.swift
//  EventApp
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    static public let reuseId = "welcomeCell"
    
    private var headerLabel = UILabel()
    private var bodyLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerLabel.font = .boldSystemFont(ofSize: 22)
        headerLabel.numberOfLines = 0
        addSubview(headerLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.backgroundColor = .clear
        bodyLabel.textColor = .darkGray
        bodyLabel.textAlignment = .center
        bodyLabel.font = .systemFont(ofSize: 18)
        bodyLabel.numberOfLines = 0
        addSubview(bodyLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(page: WelcomePageModel) {
        headerLabel.text = page.headerText
        bodyLabel.text = page.bodyText
    }
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -90),
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            bodyLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
