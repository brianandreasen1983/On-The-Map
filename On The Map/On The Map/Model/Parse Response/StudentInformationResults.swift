//
//  StudentInformationResults.swift
//  On The Map
//
//  Created by Brian Andreasen on 9/13/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

struct StudentInformationResults: Codable {
    
    let results: [StudentInformation]
//    let page: Int
//    let totalPages: Int
//    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
//        case page
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
    
}
