//
//  SearchModel.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Codable {
    let thumbnail: String
}

