//
//  FavotiteEventsCell.swift
//  EventApp 1
//
//  Created by Vova SKR on 07/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class FavoriteEventsCell: UITableViewCell {
    
    static let reuseId = "favoriteEventsCell"
    
    var customView = UIView()
    var mainImageView = UIImageView()
    
    private let headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 16), tintColor: .black, line: 3)
    private let dataLabel = UILabel.setupLabel(with: .systemFont(ofSize: 15), tintColor: .darkGray, line: 1)
    private var stackView: UIStackView!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCustomView()
        setupStackView()
        setupImageView()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(event: EventModel) {
        headerLabel.text = event.title
        dataLabel.text = "Пройдет - \(String(describing: event.dates[0].startDate ?? " "))"
        guard let url = URL(string: (event.images[0].thumbnails?.the640X384)!) else { return }
        mainImageView.loadImage(url: url, alpha: 1) { }
    }
    
}

private extension FavoriteEventsCell {
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [headerLabel, dataLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        customView.addSubview(stackView)
    }
    
    func setupCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
    }
    
    func setupImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
        customView.addSubview(mainImageView)
    }
    
    func setupLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            mainImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
        ])
    }
}
