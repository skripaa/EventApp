//
//  LoginVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    // MARK: - UI
    private lazy var imageView = UIImageView()
    private lazy var loginTF = UITextField.logIn(with: "Почта")
    private lazy var passwordTF = UITextField.logIn(with: "Пароль")
    
    private lazy var loginButton = UIButton(type: .system)
    private lazy var registrationButton = UIButton(type: .system)
    
    private lazy var mainStackView = UIStackView()
    
    
    var networkManager = NetworkManager()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Вход"
        
        setupImageVIew()
        setupStackView()
        setupButton()
        setupConstraint()
    }
    
    @objc
    func loginButtonPTap() {
        networkManager.postSingIn(email: loginTF.text!, password: passwordTF.text!) { result in
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
                    self.loginButton.shake()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if !loginTF.text!.isEmpty && passwordTF.text!.count >= 6 {
            UIView.animate(withDuration: 0.5) {
                self.loginButton.backgroundColor = .mainRed
                self.loginButton.isEnabled = true
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.loginButton.backgroundColor = .gray
            self.loginButton.isEnabled = false
        }
    }
    
    @objc
    func registrationButtonTap() {
        navigationController?.pushViewController(RegistrationVC(),
                                                 animated: true)
    }
}


// MARK: - Setup UI
private extension LoginVC {
    
    func setupTextFields() {
        loginTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.isSecureTextEntry = true
        loginTF.keyboardType = .emailAddress
        
        
        loginTF.delegate = self
        passwordTF.delegate = self
    }
    
    func setupStackView() {
        setupTextFields()
        mainStackView = UIStackView(arrangedSubviews: [loginTF, passwordTF])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 50
        mainStackView.distribution = .fillEqually
        view.addSubview(mainStackView)
        
    }
    
    func setupImageVIew() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "login")
    }
    
    func setupButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isEnabled = false
        loginButton.frame = .zero
        loginButton.layer.cornerRadius = 27
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPTap), for: .touchUpInside)
        loginButton.backgroundColor = .gray
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.tintColor = .white
        
        view.addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.frame = .zero
        registrationButton.setTitle("Еще не зарегистрированы? Нажмите сюда", for: .normal)
        registrationButton.titleLabel?.numberOfLines = 0
        registrationButton.titleLabel?.textAlignment = .center
        registrationButton.addTarget(self, action: #selector(registrationButtonTap), for: .touchUpInside)
        registrationButton.backgroundColor = .clear
        registrationButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registrationButton.tintColor = .lightBlue
        
        
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            mainStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            imageView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registrationButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15),
            registrationButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - TextField Delegate
extension LoginVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
