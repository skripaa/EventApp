//
//  DetailEvent.swift
//  EventApp 1
//
//  Created by Vova SKR on 27/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

enum SaveHelper {
    case delete
    case save
    case noAction
}

class DetailEventVC: UIViewController {
    
    // MARK: - Constants
    struct Constants {
        static fileprivate let headerHeight: CGFloat = 210
    }
    
    private var networkManager: NetworkManagerProtocol
    private var storageService: StorageServiceProtocol
    
    // MARK: - Properties
    
    private var event: EventModel
    
    private var isEventSaved: Bool {
        
        storageService.isEventSaved(event: event)
    }
    
    private var saveHelper: SaveHelper = .noAction
    private var index: Int?
    
    private var scrollView: UIScrollView!
    private var detailView: UIView!
    private var headerContainerView: UIView!
    private var headerImageView: UIImageView!
    private var placeHolderImageView: LoadingAnimationView!
    private var rightNavBarButton: UIButton!
    
    private var headerLabel: UILabel!
    private var bodyLabel: UILabel!
    private var dateLabel: UILabel!
    private var priceLabel: UILabel!
    private var addressLabel: UILabel!
    
    private var mainStackView: UIStackView!
    
    init(event: EventModel,
         networkManager: NetworkManagerProtocol,
         storageService: StorageServiceProtocol) {
        
        self.event = event
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
        
        setupView()
        
        setupConstraints()
        
        set(value: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarCustomSetting()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBarDefaultSetting()
        saveOrDeleteInFavoriteEvents()
    }
    
    // MARK: - Set Data
    func set(value: EventModel) {
        
        guard let url = URL(string: value.images[0].image) else {
            return
        }
        
        laodImage(url: url)
        
        title = value.title
        
        headerLabel.text = value.title
        bodyLabel.text = value.bodyText
        dateLabel.text = "Событие состоится - \(String(describing: value.dates[0].startDate ?? "Нет данных")) в \(String(describing: value.dates[0].startTime ?? "Нет данных"))"
        priceLabel.text = "Цена - \(value.price)"
        guard let place = value.place else { return }
        addressLabel.text = "Адрес - \(String(describing: place.address))"
        
    }
    
    private func laodImage(url: URL) {
        
        placeHolderImageView.startAnimating()
        
        headerImageView.loadImage(url: url, alpha: 1) { [weak self] in
            
            self?.placeHolderImageView.stopAnimating()
            self?.placeHolderImageView.isHidden = true
        }
    }
    
    // MARK: - Right Button Pressed
    @objc
    func rightButtonPressed() {
        
        if isEventSaved {
            
            deleteEventFromStorage()
            
        } else {
            
            saveEvent()
        }
    }
    
    
    // MARK: - Save, Detele event
    private func saveOrDeleteInFavoriteEvents() {
        
        switch saveHelper {
            
        case .noAction:
            break
            
        case .save:
            
            saveEvent()
            
        case .delete:
            
            deleteEventFromStorage()
        }
    }
    
    private func saveEvent() {
        
        guard let date = Int(Date().string()) else {
            return
        }
        
        event.date = date
        
        addActivityIndecatorInBarItem()
        
        networkManager.firebasePutData(event: event, currentDate: date) { [weak self] result in
            
            switch result {
                
            case .success:
                
                self?.storageService.append(event: self?.event)
                
            case .failure:

                break // Надо показыать какую-то ошибку
            }
            
            DispatchQueue.main.async { [weak self] in
                
                self?.addImageInBarItem()
            }
        }
    }
    
    private func deleteEventFromStorage() {
        
        guard let index = event.date else {
            return
        }
        
        addActivityIndecatorInBarItem()
        
        networkManager.firebaseDeleteData(at: index) { [weak self] result in
            
            switch result {
                
            case .success:
                
                self?.storageService.remove(event: self?.event)
                
            case .failure:

                break // Надо показыать какую-то ошибку
            }
            
            DispatchQueue.main.async { [weak self] in
                
                self?.addImageInBarItem()
            }
            
        }
    }
    
}

// MARK: - Setup UI

private extension DetailEventVC {
    
    private func addImageInBarItem() {
        let nameImage = isEventSaved ? "heartRed" : "heart"
        let image = UIImage(named: nameImage)?.withRenderingMode(.alwaysOriginal)
        let rightButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightButtonPressed))
        
        navigationItem.setRightBarButton(rightButtonItem, animated: true)
    }
    
    private func addActivityIndecatorInBarItem() {
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.style = .white
        let barButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.setRightBarButton(barButton, animated: true)
        activityIndicator.startAnimating()
    }
    
    // MARK: - Nav Bar Setting
    
    func navBarDefaultSetting() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func navBarCustomSetting() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
    }
    
    func setupView() {
        
        createDetailView()
        createScrollView()
        createHeaderContainerView()
        createHeaderImageView()
        createLabels()
        addStackView()
        addImageInBarItem()
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(detailView)
        headerContainerView.addSubview(headerImageView)
        detailView.addSubview(mainStackView)
        createPlaceHolderImage()
    }
    
    
    func createScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
    }
    
    
    func createHeaderContainerView() {
        headerContainerView = UIView()
        headerContainerView.clipsToBounds = true
        headerContainerView.backgroundColor = .gray
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func createHeaderImageView() {
        headerImageView = UIImageView()
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
    }
    
    func createPlaceHolderImage() {
        placeHolderImageView = LoadingAnimationView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))
        placeHolderImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.addSubview(placeHolderImageView)
    }
    
    
    func createDetailView() {
        detailView = UIView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = .white
        
    }
    
    func createLabels() {
        headerLabel = UILabel.setupLabel(with: .boldSystemFont(ofSize: 24), tintColor: .black, line: 0)
        headerLabel.textAlignment = .center
        
        bodyLabel = UILabel.setupLabel(with: .systemFont(ofSize: 16), tintColor: .darkGray, line: 0)
        dateLabel = UILabel.setupLabel(with: .monospacedDigitSystemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 2)), tintColor: .black, line: 0)
        priceLabel = UILabel.setupLabel(with: .systemFont(ofSize: 18), tintColor: .black, line: 0)
        addressLabel = UILabel.setupLabel(with: .systemFont(ofSize: 18), tintColor: .black, line: 0)
    }
    
    
    func addStackView() {
        
        mainStackView = UIStackView(arrangedSubviews: [headerLabel, bodyLabel, dateLabel, priceLabel, addressLabel])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
    }
    
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let headerViewTopConstraint = headerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        headerViewTopConstraint.priority = UILayoutPriority(900)
        
        NSLayoutConstraint.activate([
            headerViewTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerContainerView.bottomAnchor.constraint(equalTo: detailView.topAnchor, constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: UIScreen.main.bounds.height / 5),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -25),
            mainStackView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -25)
            
        ])
    }
}

// MARK: - ScrollView Delegate

extension DetailEventVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y / (UIScreen.main.bounds.height / 5)
        
        if offset > 0.9 { // исчкезает
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        } else { // появляется
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        }
    }
}
