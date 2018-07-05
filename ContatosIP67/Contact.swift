//
//  Contato.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class Contact: CustomStringConvertible {
    
    var name: String!
    var address: String!
    var phone: String!
    var site: String!
    var photo: UIImage!
    
    var description: String {
        return "(name: \(name!), address: \(address!), phone: \(phone!), site: \(site!)) "
    }
}

extension Contact: Equatable {
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
        
    }
}
