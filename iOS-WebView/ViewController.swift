//
//  ViewController.swift
//  iOS-WebView
//
//  Created by hideo54 on 2016/07/24.
//  Copyright © 2016年 hideo54. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        
        self.view.addSubview(webView)
        
        let views = ["webView": webView]
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-108-[webView]-0-|", options: .AlignAllTop, metrics: nil, views: views)
        )
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[webView]-0-|", options: .AlignAllTop, metrics: nil, views: views)
        )

        let url:NSURL = NSURL(string: "https://www.google.co.jp/")!
        webView.loadRequest(NSURLRequest(URL: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
        guard let url = NSURL(string: searchBar.text!) else {
            // Error handling
            return
        }
        webView.loadRequest(NSURLRequest(URL: url))
    }

}

