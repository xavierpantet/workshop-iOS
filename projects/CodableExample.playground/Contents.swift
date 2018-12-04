import UIKit

class Location: Codable {
    var longitude: String
    var latitude: String
}

class Activity: Codable {
    var name: String
    var type: String
    var category: String
    var description: String
    var price: Int
    var location: Location
}

class Category: Codable {
    var id: String
    var name: String
}

class Everything: Codable {
    var activities: [Activity]
    var categories: [Category]
}

// Chargement des données (le fichier Activities.json se trouve dans l'archive Playground)
let dirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
let fileURL = Bundle.main.url(forResource: "data", withExtension: "json")!
let content = try Data(contentsOf: fileURL)

// Décodage du fichier JSON
let data = try JSONDecoder().decode(Everything.self, from: content)


data.activities
data.categories
