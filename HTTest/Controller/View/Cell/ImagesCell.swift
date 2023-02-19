//
//  ImagesCell.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import UIKit
import SDWebImage

class ImagesCell: UICollectionViewCell {
    static let cellID = "ImagesCell"
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var imageNet: ImagesResult! {
        didSet {
            guard let url = URL(string: imageNet.thumbnail) else { return }
            image.sd_setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - SetupConstraints
extension ImagesCell {
    private func setupConstraints() {
        self.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
