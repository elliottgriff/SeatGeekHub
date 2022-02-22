//
//  DetailViewController.swift
//  SeatGeekHub
//
//  Created by elliott on 2/18/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var ticketsButton: UIButton!
    
    var event = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = event[0].title
        nameLabel.text = event[0].performers[0].name
        if let data = try? Data(contentsOf: event[0].performers[0].image) {
            eventImage.image = UIImage(data: data)
        } else {
            eventImage.image = (UIImage(named: "defaultImage"))
        }
        ticketsButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed() {
        print("pressed button")
        guard let url = URL(string: event[0].url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
