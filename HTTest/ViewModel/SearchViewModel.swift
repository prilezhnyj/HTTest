//
//  SearchViewModel.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import Foundation

class SearchViewModel {
    
    // images
    var images = [ImagesResult]()
    
    // getSerach
    func getSerach(forText text: String) {
        Network.instanse.getSerach(searchText: text) { [weak self] searchModel in
            guard let searchModel = searchModel else { return }
            self?.images = searchModel.imagesResults
        }
    }
}
