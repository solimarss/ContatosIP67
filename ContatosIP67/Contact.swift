//
//  Contato.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class Contact: NSManagedObject, MKAnnotation {
    
    //@NSManaged anotacao do CoreData um ORM para persistencia em banco de dados
    @NSManaged var name: String!
    @NSManaged var address: String!
    @NSManaged var phone: String!
    @NSManaged var site: String!
    @NSManaged var photo: UIImage!
    @NSManaged var latitude: NSNumber!
    @NSManaged var longitude: NSNumber!
    
    var coordinate: CLLocationCoordinate2D {
        
        if latitude == 0 || longitude == 0 {
            return kCLLocationCoordinate2DInvalid
        }
        
        return CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return phone
    }
    
  
    
    override var description: String {
        return "(name: \(name!), address: \(address!), phone: \(phone!), site: \(site!)) "
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
    }
    
    

}


    

