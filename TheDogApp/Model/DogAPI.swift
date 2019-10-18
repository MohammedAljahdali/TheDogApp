//
//  DogAPI.swift
//  TheDogApp
//
//  Created by Mohammed Khakidaljahdali on 15/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    
     enum UrlGenrator {
        case randomDogPicture
        case listOfAllBreads
        case randomBreadPicture(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomDogPicture:
                return "https://dog.ceo/api/breeds/image/random"
            case .listOfAllBreads:
                return"https://dog.ceo/api/breeds/list/all"
            case .randomBreadPicture(let bread):
                return "https://dog.ceo/api/breed/\(bread)/images/random"
            }
        }
    }
    
    
    
    class func requestDogImage(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                print("error DogAPI/requestDogImage")
                return
            }
            let dogImage = UIImage(data: data)
            completionHandler(dogImage, nil)
        }
        task.resume()
    }
    
    class func requestDogImageUrl(url: URL, completionHandler: @escaping (URL?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                print("error DogAPI/requestDogImageUrl")
                return
            }
            let decode = JSONDecoder()
            do {
                let dogData = try decode.decode(DogData.self, from: data)
                let dogImageUrl = URL(string: dogData.message)
                completionHandler(dogImageUrl, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class func requestBreadsList(url: URL, completionHandler: @escaping ([String]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("printBreads error"); return }
            let decoder = JSONDecoder()
            do {
                let breadsList = try decoder.decode(BreadsList.self, from: data)
                let breadsNames = breadsList.breadsList.keys.map({$0})
                print(breadsNames)
                completionHandler(breadsNames, nil)
            } catch {
                print("bread list error")
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
