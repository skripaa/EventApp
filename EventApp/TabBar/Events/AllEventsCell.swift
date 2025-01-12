//
//  AllEventsCell.swift
//  EventApp 1
//
//  Created by Vova SKR on 24/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class AllEventsCell: UITableViewCell {
    
    static let reuseId = "allEventsCell"
    
    // MARK: - Constants
    
    struct Constants {
        static fileprivate let cornerRadius: CGFloat = 20
    }
    
    
    // MARK: - Properties
    
    private let backgroundImage = UIImageView()
    private let placeHolderImageView = LoadingAnimationView()
    private let eventView = UIView()
    private var stackView: UIStackView!
    
    private let headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 20), tintColor: .white, line: 3)
    private let bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 14), tintColor: .white, line: 2)
    private let dateLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .white, line: 2)
    private let categoryLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .white, line: 1)
    
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setEventView()
        setImageView()
        setStackView()
        setLayoutConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set value
    
    public func set(value: EventModel) {
        
        headerLabel.text = value.title
        bodyLabel.text = value.bodyText
        dateLabel.text = value.dates[0].startDate
        guard let url = URL(string: (value.images[0].thumbnails?.the640X384)!) else { return }
        backgroundImage.loadImage(url: url, alpha: 0.55) { [weak self] in
            self?.placeHolderImageView.stopAnimating()
            self?.placeHolderImageView.isHidden = true
        }
    }
    
    public func setPlaceHolder() {
        placeHolderImageView.isHidden = false
        placeHolderImageView.startAnimating()
        headerLabel.text = nil
        bodyLabel.text = nil
        dateLabel.text = nil
        
    }
}

// MARK: - Configure View

private extension AllEventsCell {
    
    func setEventView() {
        self.addSubview(eventView)
        eventView.backgroundColor = .black
        addShadow()
        
    }
    
    
    func addShadow() {
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.layer.cornerRadius = Constants.cornerRadius
        eventView.layer.shadowColor = UIColor.black.cgColor
        eventView.layer.shadowOpacity = 0.4
        eventView.layer.shadowRadius = 10
        eventView.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    func setImageView() {
        eventView.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.layer.cornerRadius = Constants.cornerRadius
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        
        setPlaceHolderImage()
    }
    
    
    func setPlaceHolderImage() {
        backgroundImage.addSubview(placeHolderImageView)
        placeHolderImageView.frame = CGRect(x: 0, y: 0, width: 400, height: 250)
        placeHolderImageView.layer.cornerRadius = Constants.cornerRadius
        placeHolderImageView.clipsToBounds = true
        placeHolderImageView.backgroundColor = .lightGray
    }
    
    
    func setStackView() {
        stackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        eventView.addSubview(stackView)
    }
    
    
    // MARK: - Set Constraints
    
    
    func setLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            eventView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            eventView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            eventView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            eventView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: eventView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: eventView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: eventView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: eventView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 5/6)
        ])
    }
}



//    private func setCategoryLabelConstaints() {
//        eventView.addSubview(categoryLabel)
//        categoryLabel.text = "Category"
//        categoryLabel.backgroundColor = .red
//
//        NSLayoutConstraint.activate([
//            categoryLabel.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 15),
//            categoryLabel.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 15)
//        ])
//    }


