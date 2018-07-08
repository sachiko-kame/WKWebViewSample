//
//  ViewController.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var ShowTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowTextView.isEditable = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func WebTap(_ sender: Any) {
        print("Web見る")
        let WebViewController = WKWebViewController()
        self.navigationController?.pushViewController(WebViewController, animated: true)
    }
    
    
    @IBAction func Web2tap(_ sender: Any) {
        let WebViewController = WKWebViewController_2()
        self.navigationController?.pushViewController(WebViewController, animated: true)
    }
    
    @IBAction func DeleateCookie(_ sender: Any) {
        Cookie.shared.allremovecookie()
    }
    
    @IBAction func ShowTap(_ sender: Any) {
        ShowTextView.text = "\(String(describing: Cookie.shared.getCookie()))"
    }
}



