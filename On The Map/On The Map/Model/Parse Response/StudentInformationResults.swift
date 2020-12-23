//
//  StudentInformationResults.swift
//  On The Map
//
//  Created by Brian Andreasen on 9/13/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.

import Foundation

struct StudentInformationResults: Codable {
    
    let results: [StudentInformation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
