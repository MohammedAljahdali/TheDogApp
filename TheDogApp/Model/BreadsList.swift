//
//  File.swift
//  TheDogApp
//
//  Created by Mohammed Khakidaljahdali on 17/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

class BreadsList: Codable {
    let breadsList: [String: [String]]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case breadsList = "message"
        case status
    }
}
