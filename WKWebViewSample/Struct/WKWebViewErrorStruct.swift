//
//  WKWebViewErrorStruct.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/08/06.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

struct WKWebViewErrorStruct {
    let error:Error
    var code: Int
    var errorUrl: String

    init(erro:Error){
        self.error = erro
        
        let localError = error as NSError
        self.code = localError.code
        let errorUserInfo = localError.userInfo
        
        if let u = errorUserInfo["NSErrorFailingURLStringKey"] {
            self.errorUrl = u as? String
        }else{
           self.errorUrl = ""
        }

    }
}
