//
//  RegistrationVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 06/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    
    // MARK: - UI
    private lazy var imageView = UIImageView()
    private lazy var loginTF = UITextField.logIn(with: "Почта")
    private lazy var passwordTF = UITextField.logIn(with: "Пароль (не менее 6 символов)")
    private lazy var repeatPasswordTF = UITextField.logIn(with: "Повторите пароль")
    private lazy var registrationButton = UIButton(type: .system)
    private lazy var mainStackView = UIStackView()
    
    
    var networkManager = NetworkManager()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Регистрация"
        
        setupStackView()
        setupButton()
        setupImageVIew()
        setupConstraint()
    }
    
    
    @objc
    func registrationButtonTap() {
        networkManager.postSingUp(email: loginTF.text!, password: passwordTF.text!) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    guard let userId = user.localId, let userName = user.email else { return }
                    UserDefaults.standard.setUserId(id: userId, userName: userName)
                    print(userId)
                    AppDelegate.shared?.rootViewController?.showMainScreen()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.registrationButton.shake()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if !loginTF.text!.isEmpty
            && passwordTF.text!.count >= 6
            && passwordTF.text! == repeatPasswordTF.text! {
            
            UIView.animate(withDuration: 0.5) {
                self.registrationButton.backgroundColor = .mainRed
                self.registrationButton.isEnabled = true
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.registrationButton.backgroundColor = .gray
            self.registrationButton.isEnabled = false
        }
    }
    
    
}

// MARK: - Setup UI

private extension RegistrationVC {
    
    
    func setupTextFields() {
        loginTF.addTarget(self, action:
            #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action:
            #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        passwordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true
        loginTF.keyboardType = .emailAddress
        
        loginTF.delegate = self
        passwordTF.delegate = self
        repeatPasswordTF.delegate = self
    }
    
    func setupStackView() {
        setupTextFields()
        
        passwordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true
        
        mainStackView = UIStackView(arrangedSubviews: [loginTF, passwordTF, repeatPasswordTF])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 40
        mainStackView.distribution = .fillEqually
        view.addSubview(mainStackView)
    }
    
    func setupImageVIew() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "adduser")
    }
    
    func setupButton() {
        view.addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.isEnabled = false
        registrationButton.frame = .zero
        registrationButton.layer.cornerRadius = 27
        registrationButton.setTitle("Зарегестрироваться", for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationButtonTap), for: .touchUpInside)
        registrationButton.backgroundColor = .gray
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        registrationButton.tintColor = .white
    }
    
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            mainStackView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            registrationButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
        
        
    }
}

// MARK: - TextField Delegate
extension RegistrationVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

