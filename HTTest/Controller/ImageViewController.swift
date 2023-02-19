//
//  ImageViewController.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import UIKit
import WebKit

class ImageViewController: UIViewController {
    
    // Photo collectionView
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // previousButton
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // nextButton
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // sourceButton
    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Source", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // arrayImage
    var currentImageIndexPath: IndexPath
    
    // viewModel
    var viewModel: SearchViewModel
    
    // MARK: init
    init(currentImageIndexPath: IndexPath, viewModel: SearchViewModel) {
        self.currentImageIndexPath = currentImageIndexPath
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: life cycles
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Current Image"
        setupConstraints()
        setupCollectionView()
        setupTargets()
    }
    
    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageCollectionView.performBatchUpdates {
            imageCollectionView.scrollToItem(at: currentImageIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: setup methods
    // setupTargets
    private func setupTargets() {
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
    }
    
    // setupCollectionView
    private func setupCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.cellID)
    }
}

// MARK: - @objc methods
extension ImageViewController {
    @objc private func previousButtonTapped() {
        currentImageIndexPath.item -= 1
        imageCollectionView.scrollToItem(at: currentImageIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        currentImageIndexPath.item += 1
        imageCollectionView.scrollToItem(at: currentImageIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func sourceButtonTapped() {
        let viewController = WebViewController()
        viewController.urlStr = viewModel.images[currentImageIndexPath.item].thumbnail
        present(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.cellID, for: indexPath) as! ImagesCell
        cell.imageNet = viewModel.images[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame
        return CGSize(width: size.width , height: size.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}

// MARK: - setupConstraints
extension ImageViewController {
    private func setupConstraints() {
        let buttonsStack = UIStackView(arrangedSubviews: [previousButton, sourceButton, nextButton])
        buttonsStack.alignment = .fill
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 10
        buttonsStack.contentHuggingPriority(for: .horizontal)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsStack)
        NSLayoutConstraint.activate([
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(imageCollectionView)
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
