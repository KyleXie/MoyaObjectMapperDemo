//
//  Observable+ObjectMapper.swift
//  MoyaObjectMapper
//
//  Created by Kyle Xie on 3/7/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

public extension Response {
    public func mapObject<T: Mappable>() throws -> T {
        guard let object = Mapper<T>().map(try mapJSON()) else {
            throw Error.JSONMapping(self)
        }

        return object
    }

    public func mapArray<T: Mappable>() throws -> [T] {
        guard let objects = Mapper<T>().mapArray(try mapJSON()) else {
            throw Error.JSONMapping(self)
        }
        return objects
    }
}
