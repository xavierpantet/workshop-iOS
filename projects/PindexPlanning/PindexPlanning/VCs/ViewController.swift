//
//  ViewController.swift
//  PindexPlanning
//
//  Created by Luca Verardo on 17.11.18.
//  Copyright © 2018 Luca Verardo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialisation du système de localisation
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Chargement des activités
        let jsonData = importJsonData(filePath: "Activities")
        
        /*
         Le code ci-dessous fonctionne, mais il peut être écrit plus simplement en utilisant quelques éléments de programmation fonctionnelle
         
         var activities: [PindexActivity] = []
         for activity in jsonData["data"].arrayValue {
         let activityLocation = CLLocation(latitude: CLLocationDegrees(activity["location"]["latitude"].doubleValue), longitude: CLLocationDegrees(activity["location"]["longitude"].doubleValue))
         
         let activityToAppend = PindexActivity(title: activity["name"].stringValue, description: activity["description"].stringValue, category: activity["category"].stringValue, price: activity["price"].doubleValue, location: activityLocation)
         
         activities.append(activityToAppend)
         }
         
         appDelegate.allActivities = activities
         */
        
        /*
         La fonction map() prend en argument une autre fonction (appelons-la f). Appliquée sur un tableau [a, b, c, ...] elle retourne un nouveau tableau [f(a), f(b), f(c), ...].
         Dans ce cas, jsonData contient un tableau d'activités encodées en JSON. On lui applique alors un map() avec f qui est une fonction qui transforme une activité JSON en PindexActivity. On obtient donc un tableau de PindexActivity.
         */
        appDelegate.allActivities = jsonData["data"].arrayValue.map { (activity: JSON) in
            let activityLocation = CLLocation(latitude: CLLocationDegrees(activity["location"]["latitude"].doubleValue), longitude: CLLocationDegrees(activity["location"]["longitude"].doubleValue))
            
            return PindexActivity(title: activity["name"].stringValue, description: activity["description"].stringValue, category: activity["category"].stringValue, price: activity["price"].doubleValue, location: activityLocation)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
            appDelegate.lastLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        }
    }
}
