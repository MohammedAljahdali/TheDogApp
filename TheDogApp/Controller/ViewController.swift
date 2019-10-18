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
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func changePicture(_ sender: Any) {
        requestImageUrl(url: randomDogUrl)
    }
    
    var breadsList: [String] = []
    let randomDogUrl = DogAPI.UrlGenrator.randomDogPicture.url
    let breadsListUrl = DogAPI.UrlGenrator.listOfAllBreads.url
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestImageUrl(url: randomDogUrl)
        DogAPI.requestBreadsList(url: breadsListUrl, completionHandler: breadListHelper(breadsList:error:))
        pickerView.delegate = self
        pickerView.dataSource = self

    }
    
    func breadListHelper(breadsList: [String]?, error: Error?) {
        guard let breadsList = breadsList else {print("\(error!)\n breadListHelper error"); return }
        DispatchQueue.main.async {
            self.breadsList = breadsList
            print("fine")
        }
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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breadsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return breadsList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestImageUrl(url: randomDogUrl)
    }
    
    
}
