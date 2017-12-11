//
//  ViewController.swift
//  MVVM
//
//  Created by Rohit Singh on 12/10/17.
//  Copyright © 2017 Rohit Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewModelHotTracks : ViewModelHotTracks!
    @IBOutlet weak var tableViewHotTracks: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewHotTracks.delegate = self
        self.tableViewHotTracks.dataSource = self
        
        self.viewModelHotTracks.fetchHotTracks {
            DispatchQueue.main.async(execute: {
              self.tableViewHotTracks.reloadData()
            })
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelHotTracks.numberOfRowsInTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let model = self.viewModelHotTracks.arrOfHotTracks[indexPath.row]
        cell.textLabel?.text = model.trackName
        return cell
    }
}
