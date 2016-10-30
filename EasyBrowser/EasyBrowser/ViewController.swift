//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Brian Wong on 10/29/16.
//  Copyright © 2016 Brian Wong. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView : UIProgressView!
    
    //Refactor websites into an array so we don't have to hard-code wherever we want to use them
    var websites = ["apple.com" , "hackingwithswift.com"]
    
    //Instead of dealing with the default view, just make it a web view isntead (called before viewDidLoad)
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self;
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        //Here, we will use KVO to track each time the estimated progess of the web view changes (.new). Note: #keyPath is just like #selector where it allows the compiler to check that both these things exist.
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil);
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
        //Wrap the progress view in the bar button so we can place it in the toolbar
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()//Make sure we fit content size of UIBarButtonItem fully
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))//Reload the webview using its own method, but through our toolbar
        
        toolbarItems = [progressButton, spacer, refresh]//Space elements evenly with spacer
        
        navigationController?.isToolbarHidden = false//Show navigation controller's default toolbar

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

    func openTapped(){
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    
    //This is where ALL KVO observers observe their changed values - NEED to implement this to use KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress);
        }
    }
    
    
    //WKWebView Delegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    //Controls whether we should continue navigation for any new link, clicked prompt, etc.
    //decisionHandler is an "escaping" closure which means we can either call it straight away or later on after some event (e.g. after prompting the user to continue navigation)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url!.host {
            for website in websites {
                //Check if safe websites exist somewhere in the host name
                if host.range(of: website) != nil {
                    decisionHandler(.allow)//Block we must call to tell the delegate method how we should proceed with navigation
                    return
                }
            }
        }
        
        
        //Bad url or host so don't load the link.
        decisionHandler(.cancel)
    }

}

