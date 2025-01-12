//
//  WelcomeVC.swift
//  EventApp
//
//  Created by Vova SKR on 22/11/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    private var collectionView: UICollectionView!
    private var tap: UITapGestureRecognizer!
    private var nextButton = UIButton(type: .system)
    private var skipButton = UIButton(type: .system)
    private var pageControl = UIPageControl()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupCollectionView()
        setupButton()
        setUpPageControll()
        
        setupLayoutConstraint()
    }
    
    
    //MARK: - Button Action
    @objc
    private func skipButtonTap() {
        
        UserDefaults.standard.setIsFirstTime(value: false)
        AppDelegate.shared?.rootViewController?.switchToLoginScreen()
    }
    
    @objc
    private func nextButtonTap() {
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}


// MARK: Setup UI

private extension WelcomeVC {
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: layout)
        collectionView.register(WelcomeCell.self, forCellWithReuseIdentifier: WelcomeCell.reuseId)
        
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
   
    
    // MARK: Setup Button
    
    func setupButton() {
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .mainRed
        nextButton.tintColor = .white
        nextButton.titleLabel?.font = .systemFont(ofSize: 19)
        nextButton.layer.cornerRadius = 27
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
        view.addSubview(nextButton)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitle("Пропустить", for: .normal)
        skipButton.tintColor = .gray
        skipButton.addTarget(self, action: #selector(skipButtonTap), for: .touchUpInside)
        view.addSubview(skipButton)
    }
    
    // MARK: PageControll
    
    func setUpPageControll() {
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = WelcomePageModel.all().count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .mainRed
        view.addSubview(pageControl)
    }
    
    
    
    // MARK: SetupLayout
    
    func setupLayoutConstraint() {
        
        let safeArea = self.view.safeAreaLayoutGuide
        let heightButton: CGFloat = 55
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -15),
            skipButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 80),
            skipButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -80),
            skipButton.heightAnchor.constraint(equalToConstant: heightButton)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -10),
            nextButton.leadingAnchor.constraint(equalTo: skipButton.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: skipButton.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: heightButton)
        ])
    }
}

// MARK: Delegate, DataSourse

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WelcomePageModel.all().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCell.reuseId, for: indexPath) as! WelcomeCell
        
        cell.set(page: WelcomePageModel.all()[indexPath.item])
        
        return cell
    }
}

// MARK: - ScrollView
extension WelcomeVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos + 0.5)
        nextButton.alpha = CGFloat(WelcomePageModel.all().count - 1) - scrollPos
    }
}
