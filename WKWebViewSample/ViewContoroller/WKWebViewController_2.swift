//
//  WKWebViewController_2.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import WebKit
/*ios11*/
class WKWebViewController_2: UIViewController {
    
    var wkWebView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"https://ja-jp.facebook.com/")!
        
        let configuration = WKWebViewConfiguration()
        configuration.processPool = WKProcessPool.shared
        
        self.wkWebView = WKWebView(frame: self.GatBaseframe(), configuration: configuration)
        self.wkWebView?.translatesAutoresizingMaskIntoConstraints = false
        
        wkWebView?.navigationDelegate = self
        
        var req = URLRequest(url: url)
        let header  = HTTPCookie.requestHeaderFields(with: Cookie.shared.getcookie(url: "https://ja-jp.facebook.com/")!)
        req.allHTTPHeaderFields = header
        
        //option
        //req.httpMethod = "POST"
        //let bodyData = "key1=" + "value" + "&" + "key2=" + "value"
        //req.httpBody = bodyData.data(using: .utf8)!

        self.view.addSubview(self.wkWebView!)
        self.wkWebView?.load(req)
    }
}

extension WKWebViewController_2:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow) // decisionHandlerに.allowを返さないとそこからの処理が進みません
        
        let res = navigationResponse.response as! HTTPURLResponse
        Cookie.shared.set(responce: res)
    }
}
