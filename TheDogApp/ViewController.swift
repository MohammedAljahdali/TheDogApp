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
    
    let randomDogUrlString = "https://dog.ceo/api/breeds/image/random"
    
    func loadPicture() {
        let randomDogUrl = URL(string: randomDogUrlString)
        let task = URLSession.shared.dataTask(with: randomDogUrl!) { (data, response, error) in
            guard let data = data else {print("error with request"); return }
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let url = URL(string: json["message"] as! String)
            let task2 = URLSession.shared.dataTask(with: url!) { (data, response, error) in

                let dogImage = UIImage(data: data!)
            DispatchQueue.main.async {
                self.dogImageView.image = dogImage
            }
            }
            task2.resume()
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPicture()
    }


}

