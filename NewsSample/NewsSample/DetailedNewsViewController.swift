//
//  ViewController.swift
//  NewsSample
//
//  Created by mac on 2018. 4. 23..
//  Copyright © 2018년 StudioKJ. All rights reserved.
//

import UIKit
import WebKit

class DetailedNewsViewController: UIViewController {
    
    var detailedNewsLink : String?
    
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if let link = detailedNewsLink {
            let url: URL = URL(string: link)!
            webView!.loadRequest(URLRequest(url: url))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

