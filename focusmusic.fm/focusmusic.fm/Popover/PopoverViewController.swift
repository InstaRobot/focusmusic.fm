//
//  PopoverViewController.swift
//  focusmusic.fm
//
//  Created by Vitaliy Podolskiy on 05.04.2020.
//  Copyright © 2020 DEVLAB Studio, LLC. All rights reserved.
//

import Cocoa
import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

class PopoverViewController: NSViewController {

    @IBOutlet private(set) weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://focusmusic.fm") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    @IBAction private func reload(_ sender: Any) {
        webView.load("https://focusmusic.fm")
    }
    
}
