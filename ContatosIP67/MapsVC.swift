//
//  MapsVC.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/4/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import MapKit

class MapsVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         locationManager.requestWhenInUseAuthorization()
        
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        
    }

}
