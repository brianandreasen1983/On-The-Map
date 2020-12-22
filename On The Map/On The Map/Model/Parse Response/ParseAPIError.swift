//
//  ParseAPIError.swift
//  On The Map
//
//  Created by Brian Andreasen on 9/13/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct ParseAPIError: Codable {
    let status: Int
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
    }
}

extension ParseAPIError: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
