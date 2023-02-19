//
//  ViewController.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import UIKit

class ImagesViewController: UIViewController {
    
    // searchBar
    private let searchBar = UISearchBar()
    
    // collectionView
    private let imagesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // viewModel
    private var viewModel = SearchViewModel()
    
    // MARK: life cycles
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Images"
        setupConstraints()
        setupSearchController()
        setupCollectionView()
    }
    
    // MARK: setup methods
    // setupSearchController
    private func setupSearchController() {
        searchBar.placeholder = " Search..."
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    // setupCollectionView
    private func setupCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.cellID)
    }
}

// MARK: - UICollectionViewDataSource
extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.cellID, for: indexPath) as! ImagesCell
        cell.imageNet = viewModel.images[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ImageViewController(currentImageIndexPath: indexPath, viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame
        return CGSize(width: size.width / 3, height: size.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}

// MARK: - UISearchBarDelegate
extension ImagesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.getSerach(forText: searchText)
            self?.imagesCollectionView.reloadData()
        }
    }
}

// MARK: - setupConstraints
extension ImagesViewController {
    private func setupConstraints() {
        view.addSubview(imagesCollectionView)
        NSLayoutConstraint.activate([
            imagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

