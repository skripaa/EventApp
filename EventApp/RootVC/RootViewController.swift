//
//  RootViewController.swift
//  EventApp 1
//
//  Created by Vova SKR on 23/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    var current: UIViewController = PresentVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        
    }
    
    func switchToLoginScreen() {
        
        let loginViewController = UINavigationController(rootViewController: LoginVC())
        animateFadeTransition(to: loginViewController)
    }
    
    func switchToLoginScreenWithFlip() {
        
        let loginViewController = UINavigationController(rootViewController: LoginVC())
        animateDismissTransition(to: loginViewController)
    }
    
    func showMainScreenFadeTransition() {
        
        animateFadeTransition(to: MainTabBarController())
    }
    
    func showMainScreen() {
        
        animateDismissTransition(to: MainTabBarController())
    }
    
    func showPresentVC() {
        
        animateFadeTransition(to: PresentVC())
    }
    
    func showWelcomeVC () {
        
        animateFadeTransition(to: WelcomeVC())
    }
    
}

extension RootViewController {
    
    private func animateFadeTransition(to viewController: UIViewController, completion: (() -> Void)? = nil) {
        
        current.willMove(toParent: nil)
        addChild(viewController)
        
        let completion: (Bool) -> Void = { [weak self] _ in
            
            self?.current.removeFromParent()
            viewController.didMove(toParent: self)
            self?.current = viewController
            completion?()
        }
        
        transition(from: current,
                   to: viewController,
                   duration: 0.3,
                   options: [.transitionCrossDissolve, .curveEaseOut],
                   animations: nil,
                   completion: completion)
       
    }
    
    private func animateDismissTransition(to viewController: UIViewController, completion: (() -> Void)? = nil) {
        
        current.willMove(toParent: nil)
        addChild(viewController)
        
        let animations: () -> Void = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            viewController.view.frame = self.view.bounds
        }
        
         let completion: (Bool) -> Void = { [weak self] _ in
            
            self?.current.removeFromParent()
            viewController.didMove(toParent: self)
            self?.current = viewController
                completion?()
        }
        
        transition(from: current,
                   to: viewController,
                   duration: 0.5,
                   options: [.transitionFlipFromLeft, .curveEaseOut],
                   animations: animations,
                   completion: completion)
    }
}
