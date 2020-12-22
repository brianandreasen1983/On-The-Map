//
//  UdacityErrorResponse.swift
//  On The Map
//
//  Created by Brian Andreasen on 9/20/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct UdacityErrorRepsonse: Codable {
        let status: Int
        let error: String
}

extension UdacityErrorRepsonse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
