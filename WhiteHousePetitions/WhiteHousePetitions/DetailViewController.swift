//
//  DetailViewController.swift
//  WhiteHousePetitions
//
//  Created by Brian Wong on 10/29/16.
//  Copyright © 2016 Brian Wong. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView : WKWebView!
    var detailItem : [String : String]!
    
    override func loadView() {
        webView = WKWebView();
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Guard statement: Allows us to exit the enclosing scope (i.e viewDidLoad) early if condition isn't met (i.e. We have a valid detail item)
        guard detailItem != nil else
        {
            //Else condition MUST leave the enclosing scope
            return
        }
        
        //HTML styling for our text data
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }

    }

}
