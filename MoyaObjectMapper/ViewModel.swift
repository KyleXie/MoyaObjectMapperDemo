//
//  ViewModel.swift
//  MoyaObjectMapper
//
//  Created by Kyle Xie on 3/7/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import Foundation
import Moya
import ReactiveCocoa

class ViewModel {
    let user = MutableProperty<User?>(nil)
    let users = MutableProperty<[User]>([User]())

    func getUser(name: String) -> SignalProducer<User, Moya.Error> {
        return github.testProvider
            .request(.UserProfile(name))
            .mapObject(User.self)
            .on { next in
                self.user.value = next
            }
    }

    func getUsers(count: Int) -> SignalProducer<[User], Moya.Error> {
        return github.testProvider
            .request(.UserList(count))
            .mapArray(User.self)
            .on(next: { next in
                self.users.value = next
            })
    }
}
