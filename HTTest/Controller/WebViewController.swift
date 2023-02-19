//
//  WebViewController.swift
//  HTTest
//
//  Created by Максим Боталов on 19.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // webView
    private let webView = WKWebView()
    
    var urlStr = ""
    
    // MARK: life cycles
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        
        guard let url = URL(string: urlStr) else { return }
        webView.load(URLRequest(url: url))
    }
}

// MARK: - setupConstraints
extension WebViewController {
    private func setupConstraints() {
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
