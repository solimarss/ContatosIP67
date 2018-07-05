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
    let dao = ContactDAO.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         locationManager.requestWhenInUseAuthorization()
        
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.addAnnotations(dao.findAll())
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.removeAnnotations(dao.findAll())
    }
}

extension MapsVC: MKMapViewDelegate {
 
    //metodo chamando sempre que e feito um   mapView.addAnnotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //A apple nao permite que o pino do uusario seja customizado
        if annotation is MKUserLocation
        {
            return nil
        }
        
        let identifier = "pin_ID"
        let pin = getPin(with: identifier, annotation: annotation)
       
        pin.pinTintColor = .green
        
        if let contact = annotation as? Contact {
            pin.canShowCallout = true
            
            let frame  = CGRect(x: 0, y: 0, width: 32, height: 32)
            let imageView = UIImageView(frame: frame)
            imageView.image = contact.photo
            pin.leftCalloutAccessoryView = imageView
        }
        
        return pin
        
    }
    
    private func getPin(with identifier: String, annotation: MKAnnotation) -> MKPinAnnotationView {
        guard let pin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        return pin
    }
    
    //metodo cgamado ao tocar no pino
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        //fazer zoom ao toca no pino
        
        guard  let annotation = view.annotation else {
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    

    
    
}





