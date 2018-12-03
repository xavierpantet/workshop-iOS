//
//  ActivityChooser.swift
//  PindexPlanning
//
//  Created by Luca Verardo on 17.11.18.
//  Copyright © 2018 Luca Verardo. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var oPckView: UIPickerView!
    var jsonData = JSON([:])
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuration du PickerView
        oPckView.delegate = self
        oPckView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Chargement des données
        jsonData = importJsonData(filePath: "Activities")
    }
    
    // Gestion du clic sur le bouton
    @IBAction func btnLetsGo(_ sender: Any) {
        
        // On mémorise le choix de l'utilisateur dans les UserDefaults
        let choosedRestaurant = jsonData["restaurantType"][oPckView.selectedRow(inComponent: 0)]["id"].stringValue
        UserDefaults.standard.set(choosedRestaurant, forKey: "restaurantType")
    }
    
    // Nombre de composants dans le PickerView (ici il n'y a que le type d'activité, donc on retourne 1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Nombre d'éléments à afficher dans le PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jsonData["restaurantType"].count
    }
    
    // Texte à afficher pour le row-ième élément du PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jsonData["restaurantType"][row]["name"].stringValue
    }
}
