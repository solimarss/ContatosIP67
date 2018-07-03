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
    static let shared = ContactDAO()
    
    //private static var instance: ContactDAO!
    
    //static func sharedInstance() -> ContactDAO {
      //  if instance == nil {
        //    instance = ContactDAO()
        //}
    //}
    
    private override init() {
        contacts = Array()
    }
    
    func add(newContact contact: Contact) {
        contacts.append(contact)
        print(contacts)
    }
    
    func size() -> Int {
        return contacts.count
    }
    
    func findBy(position: Int) -> Contact {
        return contacts[position]
    }
    
    func remove(byId id: Int) {
        contacts.remove(at: id)
    }
    
    func getPosition(by contact: Contact) -> Int? {
       return contacts.index(where: {other in return other.name == contact.name })
    }
    
}


