//
//  Models.swift
//  MoyaObjectMapperDemo
//
//  Created by Kyle Xie on 3/5/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    var success: Bool?
    var message: String?
    var errCode: String?

    required init?(_ map: Map) {}

    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        errCode <- map["err_code"]
    }

}

class User: BaseModel {
    var username: String?
    var age: Int?
    var bestFriend: User?
    var friends: [User]?

    required init?(_ map: Map) {
        super.init(map)
    }

    override func mapping(map: Map) {
        super.mapping(map)

        username <- map["username"]
        age <- map["age"]
        bestFriend <- map["best_friend"]
        friends <- map["friends"]
    }
}