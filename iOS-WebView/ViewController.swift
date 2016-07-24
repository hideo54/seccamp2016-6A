//
//  ViewController.swift
//  iOS-WebView
//
//  Created by hideo54 on 2016/07/24.
//  Copyright © 2016年 hideo54. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UISearchBarDelegate, WKUIDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        
        webView.allowsBackForwardNavigationGestures = true
        webView.UIDelegate = self
        webView.addObserver(self, forKeyPath: "URL", options: .New, context: nil)
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
            let alertController = UIAlertController(title: "Incorrect URL", message: "Input a correct URL.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        webView.loadRequest(NSURLRequest(URL: url))
    }

    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let defaultNavBarTintColor = self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationItem.title = "!!!Alertだよ!!!"
        let alertController = UIAlertController(title: "Alert表示", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.navigationController?.navigationBar.barTintColor = defaultNavBarTintColor
            self.navigationItem.title = "WebView"
            completionHandler()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String?) -> Void) {
        let defaultNavBarTintColor = self.navigationController?.navigationBar.barTintColor
        self.navigationController?.navigationBar.barTintColor = UIColor.greenColor()
        self.navigationItem.title = "!!!Promptだよ!!!"
        let alertController = UIAlertController(title: "Prompt表示", message: prompt, preferredStyle: .Alert)
        var alertTextField:UITextField!
        alertController.addTextFieldWithConfigurationHandler{textField in
            textField.text = defaultText
            alertTextField = textField
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            self.navigationController?.navigationBar.barTintColor = defaultNavBarTintColor
            self.navigationItem.title = "WebView"
            completionHandler(alertTextField.text)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let path:String = keyPath else {
            return
        }
        switch path {
        case "URL":
            searchBar.text = webView.URL?.absoluteString
        default:
            break
        }
    }

}

