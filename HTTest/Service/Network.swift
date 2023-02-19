//
//  Network.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import Foundation

final class Network {
    
    // singleton
    static let instanse = Network()
    
    // create request
    private func request(searchText: String, completion: @escaping (Data?, Error?) -> Void) {
        let urlStr = "https://serpapi.com/search.json?q=\(searchText)&tbm=isch&ijn=0"
        guard let url = URL(string: urlStr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = dataTask(from: request, completion: completion)
        task.resume()
    }
    
    // create task
    private func dataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
        }
    }
    
    // parseJSON
    private func parseJSON(forData data: Data) -> SearchModel? {
        do {
            let model = try JSONDecoder().decode(SearchModel.self, from: data)
            return model
        } catch {

        }
        return nil
    }
    
    // getSerach
    func getSerach(searchText: String?, completion: @escaping (SearchModel?) -> Void) {
        guard searchText != "" else { return }
        request(searchText: searchText!) { [weak self] data, error in
            if let data = data {
                let model = self?.parseJSON(forData: data)
                completion(model)
            }
            completion(nil)
        }
    }
}

