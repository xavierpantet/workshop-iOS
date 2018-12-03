//
//  Functions.swift
//  PindexPlanning
//
//  Created by Luca Verardo on 18.11.18.
//  Copyright © 2018 Luca Verardo. All rights reserved.
//

import Foundation
import CoreLocation

class PindexActivity {
    
    var title: String
    var description: String
    var category: String
    var price: Double
    var location: CLLocation
    
    public init(title: String, description: String, category: String, price: Double, location: CLLocation) {
        self.title = title
        self.description = description
        self.price = price
        self.location = location
        self.category = category
    }
}


/*
    Cette fonction a été réécrite pour être plus lisible :-)
    Notez que vous pouvez traiter plusieurs Optionals à la fois avec le if let
 */
func importJsonData(filePath: String) -> JSON {
    if let path = Bundle.main.path(forResource: filePath, ofType: "json"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
        let jsonData = try? JSON(data: data) {
        return jsonData
    }
    
    return JSON(["error": true])
}
