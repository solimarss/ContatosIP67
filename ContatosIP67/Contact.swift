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
    
    var description: String {
        return "(name: \(name!), address: \(address!), phone: \(phone!), site \(site!)) "
    }
}
