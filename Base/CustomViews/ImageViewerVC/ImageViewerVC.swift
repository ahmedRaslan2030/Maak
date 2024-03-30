//
//  ImageViewerVC.swift
//  LocationClient
//
//  Created by Ahmed Raslan on 13/10/2023.
//

import UIKit

struct ImageViewerItem {
    let urlImage: String?
    let dataImage: Data?
}

class ImageViewerVC: UIViewController {

    //MARK: - IBOutlet -
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties -
    private var viewTranslation = CGPoint(x: 0, y: 0)
    private var items: [ImageViewerItem] = []
    private var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
   
    
    
    //MARK: - Overriden Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupDesign()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collectionView.scrollToItem(at: selectedIndex, at: .centeredHorizontally, animated: false)
        UIView.animate(withDuration: 0.2) {
            self.collectionView.alpha = 1
        }
    }
    
    //MARK: - Design Methods -
    private func setupDesign() {
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        self.collectionView.alpha = 0
    }
    
    //MARK: - Objc Methods -
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                self.view.backgroundColor = UIColor(resource: .mainBackground).withAlphaComponent(0.5)
                
            })
        case .ended:
            if viewTranslation.y < 200 && viewTranslation.y > -200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.collectionView.transform = .identity
                    self.view.backgroundColor =  UIColor(resource: .mainBackground)
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                    self.collectionView.alpha = 0
                    self.view.backgroundColor =  UIColor(resource: .mainBackground).withAlphaComponent(0)
                } completion: { (_) in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        default:
            break
        }
    }
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true)
    }
    
}

extension ImageViewerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Setup Collection View -
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: ImageViewerCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageViewerCell.identifier)
    }
    
    //MARK: - UICollectionViewDataSource -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewerCell.identifier, for: indexPath) as? ImageViewerCell else { return UICollectionViewCell()}
        cell.setupCell(image: self.items[indexPath.row])
        return cell
    }
    //MARK: - UICollectionViewDelegateFlowLayout -
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionView.bounds.height)
    }
    
}


