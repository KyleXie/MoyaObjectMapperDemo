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
import ReactiveCocoa

private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, Moya.Error> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! Moya.Error)
    }
}


extension SignalProducerType where Value == Moya.Response, Error == Moya.Error {
    public func mapObject<T: Mappable>(type: T.Type) -> SignalProducer<T, Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<T, Error> in
            return unwrapThrowable { try response.mapObject() }
        }
    }

    public func mapArray<T: Mappable>(type: T.Type) -> SignalProducer<[T], Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.mapArray() }
        }
    }

}

class Network<T: TargetType> {
    let provider: ReactiveCocoaMoyaProvider<T>
    let testProvider: ReactiveCocoaMoyaProvider<T>

    required init() {
        provider = ReactiveCocoaMoyaProvider<T>()
        testProvider = ReactiveCocoaMoyaProvider<T>(stubClosure: ReactiveCocoaMoyaProvider.ImmediatelyStub)
    }
}

let github = Network<GitHub>()
