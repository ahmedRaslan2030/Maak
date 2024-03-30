//
//  IntroPageController.swift
//  Artist
//
//  Created by AAIT on 23/08/2023.
//

import UIKit

class IntroPageController: UIPageViewController {
    
    //MARK: - Properties -
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private var subVC = [UIViewController]()
    private var intros:  [Intro] = [
        Intro(
              id: 0,
              title: "Welcome".localized,
              description: "Welcome to our app".localized,
              image: "firstIntroImage"
             ),
        Intro(
              id: 0,
              title: "Readiness".localized,
              description: "A group of professional experts is ready 24h to help you".localized,
              image: "secondIntroImage"
             ),
        
        Intro(
              id: 0,
              title: "SpareParts".localized,
              description: "An inventory of spare parts for so many  brands".localized,
              image: "thirdIntroImage"
             ),
    ]
 
    private lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl(frame: .zero)
        pageControl.isUserInteractionEnabled = false
        pageControl.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        pageControl.currentPageIndicatorTintColor = UIColor(resource: .secondary)
        pageControl.tintColor = UIColor(resource: .secondaryDarkFont)
        pageControl.pageIndicatorTintColor = UIColor(resource: .secondaryDarkFont)
        return pageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next".localized, for: .normal)
        button.tintColor =  .white
        button.backgroundColor = UIColor(resource: .main)
        button.layer.cornerRadius = ViewConstants.shared.smallCornerRadius
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(nextButtonWasPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip".localized, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(resource: .mainDarkFont), for: .normal)
        button.addTarget(self, action: #selector(skipButtonWasPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private var isLast = false {
        didSet {
            self.nextButton.setTitle( isLast ? "Start".localized : "Next".localized, for: .normal)
        }
    }

  
    

    
    // MARK: - Init -

    init(intros: [Intro]){
//        self.intros = intros
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confguration()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraint()
    }
    
    //MARK: - Design Methods -
    
    private func confguration() {
        createControllers(intro: intros)
        setupPageController()
        configureUI()
    }
    
    private func configureUI() {
        self.isLast = subVC.count == 1
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        pageControl.numberOfPages = subVC.count
        pageControl.semanticContentAttribute = Language.isRTL() ? .forceRightToLeft : .forceLeftToRight
        
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    private func setupConstraint() {
        
        skipButton.constrainHeight(constant: 48)
        
        skipButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                          leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: nil,
                          trailing: nil,
                          padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        nextButton.anchor(top: nil,
                          leading: self.view.leadingAnchor,
                          bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: self.view.trailingAnchor,
                          padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        nextButton.constrainHeight(constant: 48)
        
        pageControl.anchor(top: nil,
                           leading: self.view.leadingAnchor,
                           bottom: self.nextButton.topAnchor,
                           trailing: self.view.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 16, right: 0))
        
        pageControl.centerXInSuperview()
    }
    
    @objc private func nextButtonWasPressed(_ sender: UIButton) {
        self.isLast ? goToAuth() : goToNextPage()
    }
    
    @objc private func skipButtonWasPressed(_ sender: UIButton) {
        goToAuth()
    }
    
    
    private func createControllers(intro: [Intro]?) {
        guard let intro = intro else { return }
        self.subVC.removeAll()
        intro.enumerated().forEach { (index, intro) in
            self.subVC.append(IntroFactory.makeIntroVC(image: intro.image, title: intro.title, body: intro.description, tag: index))
        }
    }
    
    
    
    private func goToAuth() {
        UserDefaults.isFirstTime = false
        AppCoordinator.shared.changeFlow(navigationFlow: .auth)
    }
}

extension IntroPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private func setupPageController() {
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([self.subVC[0]], direction: Language.isRTL() ? .reverse : .forward, animated: true, completion: nil)
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentPage = viewControllers?.first else{ return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else{ return }
        guard let currentIndex = subVC.firstIndex(of: nextPage) else{return}
        self.pageControl.currentPage = currentIndex
        self.isLast = currentIndex == subVC.count - 1
        setViewControllers([nextPage], direction: Language.isRTL() ? .reverse : .forward, animated: animated, completion: nil)
    }
    private func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        let currentIndex = subVC.firstIndex(of: previousViewController) ?? 0
        self.pageControl.currentPage = currentIndex
        self.isLast = currentIndex == subVC.count - 1
        setViewControllers([previousViewController], direction: Language.isRTL() ? .forward : .reverse, animated: animated, completion: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.subVC.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subVC.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        if currentIndex <= 0 {
            return nil
        }
        self.isLast = currentIndex == subVC.count - 1
        return subVC[currentIndex - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subVC.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        if currentIndex >= subVC.count - 1 {
            return nil
        }
        self.isLast = currentIndex == subVC.count - 1
        return subVC[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return }
        pageControl.currentPage = pageViewController.viewControllers!.first!.view.tag
        self.isLast = pageControl.currentPage == subVC.count - 1
    }
}
