//
//  ProfileVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let storageService: StorageServiceProtocol
    
    private lazy var profileImage = UIImageView()
    private lazy var profileName = UILabel.setupLabel(with: .systemFont(ofSize: 24), tintColor: .black, line: 2)
    private lazy var signOutButton = UIButton(type: .system)
    private var stackView: UIStackView!
    
    var defaults = UserDefaults.standard
    
    init(storageService: StorageServiceProtocol) {
        
        self.storageService = storageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        profileName.text = UserDefaults.standard.userEmail()
        setupProfileImage()
        setupStackView()
        setupButton()
        
        setupLayuotConstraint()
    }
}


extension ProfileVC {
    
    func setupProfileImage() {
        view.addSubview(profileImage)
        profileImage.frame.size = CGSize(width: 150, height: 150)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        profileImage.image = UIImage(named: "profilePlaceHolder")
    }
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [profileImage, profileName])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        view.addSubview(stackView)
    }
    
    func setupButton() {
        view.addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.frame = .zero
        signOutButton.layer.cornerRadius = 25
        signOutButton.setTitle("Выйти", for: .normal)
        signOutButton.addTarget(self, action: #selector(singOutButtonTap), for: .touchUpInside)
        signOutButton.backgroundColor = .gray
        signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signOutButton.tintColor = .white
    }
    
    func setupLayuotConstraint() {
        
        NSLayoutConstraint.activate([
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 250),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    @objc
    func singOutButtonTap() {
        
        storageService.updateSavedEvents(newList: [])
        defaults.deleteUserId()
        
        AppDelegate.shared?.rootViewController?.switchToLoginScreenWithFlip()
    }
}
