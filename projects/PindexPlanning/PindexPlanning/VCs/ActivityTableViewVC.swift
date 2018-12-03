//
//  activityTableViewVC.swift
//  PindexPlanning
//
//  Created by Luca Verardo on 18.11.18.
//  Copyright © 2018 Luca Verardo. All rights reserved.
//

import UIKit
import CoreLocation

class ActivityCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtvDescription: UITextView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
}

class ActivityTableViewVC: UITableViewController {
    
    var dayStrings = ["morningActivity", "restaurantType", "eveningActivity"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Nombre de sections dans la TableView (nous n'avons qu'une seule section donc on retourne 1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Nombre d'éléments à afficher dans la TableView (on veut toujours 3)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // Retourne la nième cellule à afficher dans la TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // On récupère la cellule réutilisable
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityCell
        
        // On récupère une activité à afficher
        let activity = getActivity(userKey: dayStrings[indexPath.row])
        
        // On remplit la cellule avec les valeurs désirées
        cell.lblTitle.text = activity.title
        cell.txtvDescription.text = activity.description
        cell.lblPrice.text = String(activity.price) + " CHF"
        
        // Si la localisation n'a pas pu être déterminée, on affiche un "-", sinon on calcule la distance entre l'activité et celle-ci
        cell.lblDistance.text = appDelegate.lastLocation == nil ? "-" : String(calculateDistance(start: appDelegate.lastLocation!, end: activity.location)) + " km"
        
        return cell
    }
    
    /*
        Cette fonction génère la liste des activités pour la catégorie et la userKey données.
        Ici userKey permet de déterminer si on cherche les activités pour le matin, le midi ou le soir.
    */
    private func getActivity(userKey: String) -> PindexActivity {
        
        let categoryType = UserDefaults.standard.string(forKey: userKey)
        let allActivities = appDelegate.allActivities
        
        /*
            Le code ci-dessous fonctionne, mais il peut être écrit plus simplement en utilisant quelques éléments de programmation fonctionnelle
 
            var matchingActivities: [PindexActivity] = []
            for activity in allActivities where activity.category == categoryType {
                matchingActivities(activity)
            }
         */
        
        /*
            La fonction filter() prend une autre fonction en argument (appelons-là f).
            Cette fonction f prend un PindexActivity en argument et retourne vrai ou faux dépendamment de celle-ci.
            Appliquée sur un tableau, filter() retourne la liste des éléments pour lequel f vaut vrai.
            Cette notation raccourcie (le $0) est une fonction anonyme.
         */
        let matchingActivities = allActivities.filter{ $0.category == categoryType }
        
        // Si aucune activité ne matche la catégorie, on retourne une cellule spéciale, sinon on en tire une au hasard parmi les activités possibles
        return matchingActivities.isEmpty ? getEmptyActivity() : matchingActivities[Int.random(in: 0 ..< matchingActivities.count)]
    }
    
    // Cette fonction retourne une activité spéciale permettant d'afficher qu'aucune activité n'a été trouvée
    private func getEmptyActivity() -> PindexActivity {
        return PindexActivity(title: "Aucune activité trouvée", description: "Relancez la recherche", category: "Aucune", price: 0, location: CLLocation(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)))
    }
    
    private func calculateDistance(start: CLLocation, end: CLLocation) -> Double {
        let distance = start.distance(from: end)/1000
        let distanceRounded = (distance*100).rounded()/100
        return distanceRounded
    }
}
