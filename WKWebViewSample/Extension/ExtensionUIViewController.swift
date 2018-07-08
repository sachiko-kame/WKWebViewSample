//
//  ExtensionUIViewController.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func GatBaseframe()->CGRect{
        
        var frame = self.view.frame
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        frame.origin.y = frame.origin.y + statusBarHeight + navBarHeight
        frame.size.height = frame.size.height - statusBarHeight - navBarHeight
        return frame
    }
}
