//
//  ContactDAO.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ContactDAO: NSObject {

    private var contacts: [Contact]//Isso e um Array
    
    override init() {
        contacts = Array()
    }
    
    func add(newContact contact: Contact) {
        contacts.append(contact)
        print(contacts)
    }
    
}


