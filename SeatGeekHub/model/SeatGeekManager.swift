//
//  SeatGeekManager.swift
//  SeatGeekHub
//
//  Created by elliott on 2/18/22.
//

import UIKit

protocol SGManagerDelegate {
    func didUpdateEvent(data: SGData)
}

struct SeatGeekManager {
    
    var delegate: SGManagerDelegate?
    
    let seatGeekURL = "https://api.seatgeek.com/2/events"
    
    func fetchData() {
        
        let urlString = "\(seatGeekURL)?client_id=\(K.SeatGeek.clientID)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let safeData = data {
                    self.parseJSON(jsonData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(jsonData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SGData.self, from: jsonData)
            let sgdata = SGData(events: decodedData.events)
            self.delegate?.didUpdateEvent(data: sgdata)
            print("sending did update event")
        } catch {
            print(error)
        }
    }
}
