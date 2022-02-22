//
//  SeatGeekModel.swift
//  SeatGeekHub
//
//  Created by elliott on 2/18/22.
//

import UIKit

struct SGData: Codable {
    
    let events: [Events]
    
}

struct Events: Codable {
    
    let performers: [Performers]
    let datetime_local: String
    let venue: Venue
    
    let title: String
    let url: String
    
}

struct Venue: Codable {
    
    let city: String
    let name: String
    
}

struct Performers: Codable {
    
    let name: String
    let image: URL
    
}


