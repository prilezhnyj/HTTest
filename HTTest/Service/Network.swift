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
        let url = createURL(param: prepareParam(searchText: searchText))
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = dataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParam(searchText: String?) -> [String: String] {
        var param = [String: String]()
        param["q"] = searchText
        param["tbm"] = "isch"
        param["ijn"] = "0"
        param["async"] = "false"
        param["api_key"] = "1f69fe6aed7cd2cf9122f55db032c5d46caf277b9708f66c321edc3750e43c32"
        return param
        
    }
    
    private func createURL(param: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "serpapi.com"
        components.path = "/search"
        components.queryItems = param.map({ URLQueryItem(name: $0, value: $1)})
        return components.url!
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

