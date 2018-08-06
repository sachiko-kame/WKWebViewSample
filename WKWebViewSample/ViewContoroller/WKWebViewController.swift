//
//  WKWebViewController.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import WebKit
/*ios10*/
class WKWebViewController: UIViewController {
    
    var wkWebView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"https://ja-jp.facebook.com/")!
        
        let configuration = WKWebViewConfiguration()
        configuration.processPool = WKProcessPool.shared
        
        self.wkWebView = WKWebView(frame: self.GatBaseframe(), configuration: configuration)
        self.wkWebView?.translatesAutoresizingMaskIntoConstraints = false
        
        wkWebView?.uiDelegate = self
        wkWebView?.navigationDelegate = self
        
        var req = URLRequest(url: url)
        let header  = HTTPCookie.requestHeaderFields(with: Cookie.shared.getcookie(url: "https://ja-jp.facebook.com/")!)
        req.allHTTPHeaderFields = header
        
        self.view.addSubview(self.wkWebView!)
        
        //option
        //補足:以下のbodyはloadだとnilになるそう　参考:https://www.lanches.co.jp/blog/8953
        //req.httpMethod = "POST"
        //let bodyData = "key1=" + "value" + "&" + "key2=" + "value"
        //req.httpBody = bodyData.data(using: .utf8)!
       
        //ios11だとbodyなくなる対策だが…
        let task = URLSession.shared.dataTask(with: req) { (data : Data?, response : URLResponse?, error : Error?) in

            DispatchQueue.main.async {

                if data != nil
                {
//                    self.wkWebView?.loadHTMLString(String(data: data!, encoding: .utf8)!, baseURL: url)
                    //or
                    self.wkWebView?.load(data!, mimeType: "text/html", characterEncodingName: "utf-8", baseURL: url)
                    //これよりもloadHTMLStringにStringでHTML直書きしてそのボタン自動的に押すの方がうまく行きました。
                }
            }
        }
        task.resume()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension WKWebViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        let a = WKWebViewErrorStruct(erro: error)
        print("\(a.errorUrl)")
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        let a = WKWebViewErrorStruct(erro: error)
        print("\(a.errorUrl)")
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        decisionHandler(.allow) // decisionHandlerに.allowを返さないとそこからの処理が進みません
        
        let res = navigationResponse.response as! HTTPURLResponse
        Cookie.shared.set(responce: res)
    }
}


extension WKWebViewController:WKUIDelegate{
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?{
        if(navigationAction.targetFrame?.isMainFrame)!{
            webView.load(navigationAction.request)
        }
        return nil
    }
}

