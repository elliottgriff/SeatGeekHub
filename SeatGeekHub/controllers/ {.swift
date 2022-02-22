//
//  ViewController.swift
//  SeatGeekHub
//
//  Created by elliott on 2/15/22.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    let model = SeatGeekModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func fetchData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        return cell
    }

}

