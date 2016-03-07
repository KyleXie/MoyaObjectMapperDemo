//
//  Network.swift
//  MoyaObjectMapperDemo
//
//  Created by Kyle Xie on 3/5/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class Network<T: TargetType> {
    private let provider: ReactiveCocoaMoyaProvider<T>

    required init(isTesting: Bool = false) {
        if isTesting {
            let endpointColosure = { (target: T) -> Endpoint<T> in
                let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
                return Endpoint(
                    URL: url,
                    sampleResponseClosure: { .NetworkResponse(200, target.sampleData) },
                    method: target.method,
                    parameters: target.parameters)
            }
            provider = ReactiveCocoaMoyaProvider<T>(endpointClosure: endpointColosure)
        } else {
            provider = ReactiveCocoaMoyaProvider<T>()
        }
    }

//    static func request<R: BaseModel>(type: T, params: [String: AnyObject]?=nil) -> SignalProducer<R, Error> {
//    }

}
