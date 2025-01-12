//
//  PresentVC.swift
//  EventApp 1
//
//  Created by Vova SKR on 10/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class PresentVC: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let imageView = UIImageView()
    let label = UILabel.setupLabel(with: .boldSystemFont(ofSize: 28), tintColor: .black, line: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        animation()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        setupImageView()
        setupLabel()
    }
    
    
    private func animation() {
        
        let fadeInAnimations: () -> Void = { [weak self] in
            
            self?.setAlphaView(alpha: 1)
        }
        
        let fadeOutAnimations: () -> Void = { [weak self] in
            
            self?.setAlphaView(alpha: 0)
        }
        
        UIView.animate(withDuration: 1, animations: fadeInAnimations) { _ in
            
            UIView.animate(withDuration: 1, delay: 0.5, animations: fadeOutAnimations) { [weak self] _ in
                
                self?.showNextViewController()
            }
        }
        
    }
    
    private func showNextViewController() {
        
        guard !defaults.isFirstTime() else {
            
            AppDelegate.shared?.rootViewController?.showWelcomeVC()
            return
        }
        
        if defaults.userId().isEmpty {
            
            AppDelegate.shared?.rootViewController?.switchToLoginScreen()
            
        } else {
            
             AppDelegate.shared?.rootViewController?.showMainScreenFadeTransition()
        }

    }
    
    private func setAlphaView(alpha: CGFloat) {
        
        imageView.alpha = alpha
        label.alpha = alpha
    }
    
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.image = UIImage(named: "kremlin")
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
            
        ])
        
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.text = "Афиша Москвы"
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.widthAnchor.constraint(equalTo: view.widthAnchor),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        
    }
    
    
    
}
