//
//  ExtensionWKProcessPool.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//
import WebKit

extension WKProcessPool {
    static var shared = WKProcessPool()
    
    func reset(){
        WKProcessPool.shared = WKProcessPool()
    }
}
