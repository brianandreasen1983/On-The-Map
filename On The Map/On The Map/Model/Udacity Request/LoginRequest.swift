//
//  LoginRequest.swift
//  On The Map
//
//  Created by Brian Andreasen on 5/26/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
}

