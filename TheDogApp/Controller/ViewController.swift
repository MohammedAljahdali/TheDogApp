//
//  ViewController.swift
//  TheDogApp
//
//  Created by Mohammed Khalid Aljahdali on 14/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    
    @IBAction func changePicture(_ sender: Any) {
        requestImageUrl(url: randomDogUrl)
    }
    
    let randomDogUrl = DogAPI.UrlGenrator.randomDogPicture.url
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestImageUrl(url: randomDogUrl)
    }
    
    func requestImageUrl(url: URL) {
        DogAPI.requestDogImageUrl(url: url, completionHandler: self.imageUrlHelper(url:error:) )
    }
    
    func imageUrlHelper(url: URL?, error: Error?) {
        guard let url = url else { print("nil url in ViewController/imageUrlHelper"); return }
        DogAPI.requestDogImage(url: url, completionHandler: self.imageLoadHelper(image:error:))
    }
    
    func imageLoadHelper(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImageView.image = image
        }
    }


}
//    func dogImage(dogData: DogData) {
//        let urlDogImage = URL(string: dogData.message)
//        let task = URLSession.shared.dataTask(with: urlDogImage!) { (data, response, error) in
//            guard let data = data else { print("error in dogImage func data"); return }
//            let dogImage = UIImage(data: data)
//            DispatchQueue.main.async {
//                self.dogImageView.image = dogImage
//            }
//
//        }
//        task.resume()
//    }
//
//    func decodeUrl(url: URL)  {
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { print("problem with data of url"); return }
//            let decode = JSONDecoder()
//            do {
//            let dogData = try decode.decode(DogData.self, from: data)
//                self.dogImage(dogData: dogData)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//
//    }
