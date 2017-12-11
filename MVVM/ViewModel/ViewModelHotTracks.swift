//
//  ViewModelHotTracks.swift
//  MVVM
//
//  Created by Rohit Singh on 12/10/17.
//  Copyright © 2017 Rohit Singh. All rights reserved.
//

import UIKit

class ViewModelHotTracks: NSObject {
    
    var arrOfHotTracks = [HotTracks]()
    
    // Fetching Data from API
    func fetchHotTracks(completion: @escaping () -> () ) {
        
        WebServiceClass.getDataFromApi { (responseDict, error) in
            if error == nil {
                self.arrOfHotTracks.removeAll()
                if let unWrapArrayOfResults = ((responseDict?["feed"]) as? Dictionary<String, Any>)?["results"] as? [Dictionary<String, Any>] {
                    for result in unWrapArrayOfResults {
                        guard let name = result["collectionName"] as? String else {return}
                        guard let url = result["artworkUrl100"] as? String else {return}
                    
                        let model = HotTracks(trackName: name, trackImageUrl: url)
                        self.arrOfHotTracks.append(model)
                    }
                    completion()
                }
            }
        }
    }
    
    
    // Functions to control the Tableview rows
    func numberOfRowsInTableView() -> Int {
        return self.arrOfHotTracks.count
    }

    
}
