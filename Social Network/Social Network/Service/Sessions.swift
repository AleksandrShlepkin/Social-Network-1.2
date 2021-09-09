//
//  Sessions.swift
//  Social Network
//
//  Created by Alex on 24.06.2021.
//

import Foundation

final class Session {
    static var shared = Session()
    private init (){}
    
    
    var token = ""
    var userID = "alexandr_gennadevich"
    var clientID: Int = 0
}
