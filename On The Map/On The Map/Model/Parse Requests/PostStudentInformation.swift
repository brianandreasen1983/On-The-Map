//
//  PostStudentInformation.swift
//  On The Map
//
//  Created by Brian Andreasen on 10/18/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct PostStudentInformation: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let latitude: Double
    let longitude: Double
    let mediaURL: String

    
    enum CodingKeys: String, CodingKey {
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case latitude
        case longitude
        case mediaURL
    }
    
}
