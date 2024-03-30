//
//  HomeVC.swift
//  Maak
//
//  Created by AAIT on 14/01/2024.
//
//  Template by Ahmed Raslan®

import SkeletonView
import UIKit

final class HomeVC: BaseVC {
    // MARK: - IBOutlets
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var wavingImage: UIImageView!
    @IBOutlet private var welcomeStack: UIStackView!
    @IBOutlet private var sliderView: SliderView!
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: - Properties -

    private lazy var notificationButton: SSBadgeButton = {
        let button = SSBadgeButton()
        button.setImage(UIImage(resource: .notify).withTintColor(UIColor(resource: .secondary)), for: .normal)
        button.tintColor = UIColor(resource: .secondary)
        return button
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .homeLogo)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private var homeData: HomeResponse?

    // MARK: - Init -

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialDesign()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeData()
        UserDefaults.isLogin == true ? getNotificationsCount() : ()
     }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImage.constrainWidth(constant: 70)
        logoImage.constrainHeight(constant: 70)
//        notificationButton.constrainHeight(constant: 70)
//        notificationButton.constrainWidth(constant: 70)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - Design Methods -

    private func configureInitialDesign() {
        view.backgroundColor = UIColor(resource: .mainBackground)
        setupNavigationBarUI()
        setupNavigationViewImage()
        configureNotificationButton()
        removeNavigationBarShadow()
        setupWelcomeStack()
        addWavingHandAnimation()
        setupCollectionView()
        scrollView.addRefresh(action:  #selector(self.refresh))
     }

    private func setupNavigationBarUI() {
        navigationController?.navigationBar.backgroundColor = .clear
    }

    private func configureNotificationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        notificationButton.autoresizingMask = .flexibleHeight
        notificationButton.addTarget(self, action: #selector(didTapNotifications(_:)), for: .touchUpInside)
    }

    private func setupNavigationViewImage() {
        navigationItem.titleView = logoImage
    }
   

    private func addWavingHandAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.wavingImage.transform = CGAffineTransform(rotationAngle: .pi / 8)
        }, completion: nil)
    }

    private func setupWelcomeStack() {
        welcomeStack.isHidden = !UserDefaults.isLogin
        userNameLabel.text = "\("welcome".localized) \(UserDefaults.user?.username ?? "")"
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: CategoryCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: HeaderView.identifier)
        collectionView.showsVerticalScrollIndicator = false
    }

    // MARK: - Actions -

    @objc private func didTapNotifications(_ sender: UIButton) {
 
    }
    
    
    @objc private func refresh() {
        getHomeData()
        scrollView.refreshControl?.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource  Methods -

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData?.categories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CategoryCell.self, for: indexPath)
        cell.configCell(image: homeData?.categories[indexPath.row].image ?? "", categoryName: homeData?.categories[indexPath.row].name ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.identifier,
            for: indexPath) as? HeaderView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        header.configure(with: "Our Services".localized)
        return header
    }
}

// MARK: -  UICollectionViewDelegate  Methods -

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = homeData?.categories[indexPath.row] else { return }
 
    }
}

// MARK: - UICollectionViewDelegateFlowLayout -

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Int(collectionView.frame.width) / 2) - 8, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

// MARK: - NetWorking -

extension HomeVC {
    private func getHomeData() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MainServices.home.send(dataType: HomeResponse.self)

                self.homeData = response.data

                self.sliderView.set(images: homeData?.images.compactMap({ $0.image }) ?? [])

                self.collectionView.reloadData()

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
            
            AppIndicator.shared.dismiss()

        }
    }
    
    
    
    private func getNotificationsCount() {
        AppIndicator.shared.show(isGif: false)
        Task {
            do {
                let response = try await MainServices.notificationsCount.send(dataType: NotificationsCount.self)
                self.notificationButton.badge = "\(response.data?.count ?? 0)"
 

            } catch {
                self.showErrorToast(with: error.localizedDescription)
            }
            
            AppIndicator.shared.dismiss()

        }
    }
}
