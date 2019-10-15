//
//  ViewController.swift
//  TheDogApp
//
//  Created by Mohammed Khakidaljahdali on 14/10/2019.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    
    @IBAction func changePicture(_ sender: Any) {
        loadPicture()
    }
    
    let randomDogUrl = DogAPI.UrlGenrator.randomDogPicture.url
    
    func loadPicture() {
        decodeUrl(url: randomDogUrl)
    }
    
    func dogImage(dogData: DogData) {
        let urlDogImage = URL(string: dogData.message)
        let task = URLSession.shared.dataTask(with: urlDogImage!) { (data, response, error) in
            guard let data = data else { print("error in dogImage func data"); return }
            let dogImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.dogImageView.image = dogImage
            }
            
        }
        task.resume()
    }
    
    func decodeUrl(url: URL)  {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("problem with data of url"); return }
            let decode = JSONDecoder()
            do {
            let dogData = try decode.decode(DogData.self, from: data)
                self.dogImage(dogData: dogData)
            } catch {
                print(error)
            }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPicture()
    }


}

