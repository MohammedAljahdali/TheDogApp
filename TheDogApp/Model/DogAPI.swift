//
//  DogAPI.swift
//  TheDogApp
//
//  Created by Mohammed Khakidaljahdali on 15/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

class DogAPI {
    
     enum UrlGenrator: String {
        case randomDogPicture = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
