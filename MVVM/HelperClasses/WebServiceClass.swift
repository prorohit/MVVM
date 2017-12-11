//
//  WebServiceClass.swift
//  CollerctionViewPractice
//
//  Created by Rohit Singh on 12/9/17.
//  Copyright © 2017 Rohit Singh. All rights reserved.
//

import UIKit

class WebServiceClass: NSObject {

   class  func getDataFromApi(_ completionHandler: @escaping (_ response: Dictionary<String, Any>?, _ error: Error?) -> ()) {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/50/explicit.json")!)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                
                guard let _:Data = data, let _:URLResponse = response, error == nil else {
                    print("error")
                    return
                }
                do {
                    let dataJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    completionHandler(dataJson as? Dictionary<String, Any>, nil)
                                        
                } catch {
                    print("Error in serializing the datas")
                }
                
            } else {
                completionHandler(nil, error)
            }
        }
        
        dataTask.resume()
        
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

