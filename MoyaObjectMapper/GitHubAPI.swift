//
//  GitHubAPI.swift
//  MoyaObjectMapperDemo
//
//  Created by Kyle Xie on 3/5/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import Foundation
import Moya

enum GitHub {
    case Zen
    case UserProfile(String)
    case UserList(Int)
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public func toJsonData(obj: AnyObject) -> NSData? {
    do {
        let jsonData = try NSJSONSerialization.dataWithJSONObject(obj, options: .PrettyPrinted)
        return jsonData
    } catch let error as NSError {
        print(error)
    }

    return nil
}

extension GitHub: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .Zen:
            return "/zen"
        case .UserProfile(let name):
            return "/users/\(name.URLEscapedString)"
        case .UserList(let count):
            return "/users/?count=\(count)"
        }
    }

    var method: Moya.Method {
        return .GET
    }

    var parameters: [String: AnyObject]? {
        return ["token": "sjLKjKJ99KJKhd", "app_version": "1.0.0(25)"]
    }

    var sampleData: NSData {
        switch self {
        case .Zen:
            return toJsonData(["success": true, "message": "ok"])!
        case .UserProfile(let name):
            return toJsonData(
                ["success": true,
                 "username": name,
                 "age": 19,
                 "best_friend": ["username": "kyle", "age": 18]])!
        case .UserList(let count):
            var result = [AnyObject]()
            for i in 1...count {
                result.append(["username": "kyle\(i)", "age": 18])
            }
            return toJsonData(result)!
        }
    }
}