//
//  Cookie.swift
//  WKWebViewSample
//
//  Created by 水野祥子 on 2018/07/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
//参考:https://github.com/keisukeYamagishi/HttpSession/blob/d65a69a8945b5ad07e4c72479f5b275f8e249a78/Lib/Lib/src/AuthKit/Cookie.swift
open class Cookie: NSObject {
    
    public static let shared: Cookie = Cookie()
    
    private override init(){}
    
    public func getCookie() -> [HTTPCookie]?{
        return HTTPCookieStorage.shared.cookies
    }
    
    public func get(url: String) -> [String : String]{
        let cookie = HTTPCookieStorage.shared.cookies(for: URL(string: url)!)
        return HTTPCookie.requestHeaderFields(with: cookie!)
    }
    
    public func getcookie(url: String) -> [HTTPCookie]?{
        let cookie = HTTPCookieStorage.shared.cookies(for: URL(string: url)!)
        return cookie
    }
    
    public func set(responce: URLResponse){
        
        let res = responce as! HTTPURLResponse
        
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: res.allHeaderFields as! [String : String], for: res.url!)
        
        for i in 0 ..< cookies.count{
            let cookie = cookies[i]
            HTTPCookieStorage.shared.setCookie(cookie)
            
        }
    }
    
    public func allremovecookie(){
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}
