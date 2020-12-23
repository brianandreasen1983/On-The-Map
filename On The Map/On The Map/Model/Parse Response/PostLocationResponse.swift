//
//  PostLocationResponse.swift
//  On The Map
//
//  Created by Brian Andreasen on 12/22/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct PostLocationResponse : Codable {
    let createdAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case objectId
    }
}


