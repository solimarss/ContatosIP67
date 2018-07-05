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
    private let coreData: CoreDataUtil<Contact>
    static let shared = ContactDAO()
    
    
    
    //private static var instance: ContactDAO!
    
    //static func sharedInstance() -> ContactDAO {
      //  if instance == nil {
        //    instance = ContactDAO()
        //}
    //}
    
    private override init() {
        
        coreData = CoreDataUtil(forEntity: .contact)
        contacts = coreData.findAll()
        
        
        
        /**
        let fernando = Contact()
        fernando.name = "Fernando"
        fernando.address = "Rua Vergueiros 3384"
        fernando.phone = "999999999"
        fernando.site = "www.google.com.br"
        fernando.latitude = -23.5896743503426
        fernando.longitude = -46.6317927313922
        contacts.append(fernando)
        
        
        let marcos = Contact()
        marcos.name = "Marcos"
        marcos.address = "Passagem Santa Matilde 78 Belem"
        marcos.phone = "999999999"
        marcos.site = "www.google.com.br"
        marcos.latitude = -1.409191
        marcos.longitude = -48.4425326
        contacts.append(marcos)
        
        
        let maria = Contact()
        maria.name = "Maria"
        maria.address = "Av. Alcindo Cacela 2010 cremacao"
        maria.phone = "999999999"
        maria.site = "www.google.com.br"
        maria.latitude = -1.45517348605158
        maria.longitude = -48.4775403422078
        contacts.append(maria)
        
        **/
        
    }
    
    func newContac() -> Contact {
        return coreData.newManaged()
    }
    
    func add(newContact contact: Contact) {
        contacts.append(contact)
        coreData.commit()
    }
    
    func update(contact: Contact) {
        coreData.commit()
    }
    
    func size() -> Int {
        return contacts.count
    }
    
    func findBy(position: Int) -> Contact {
        return contacts[position]
    }
    
    func findAll() -> [Contact] {
        return contacts
    }
    
    func remove(byId id: Int) {
        let contact = findBy(position: id)
        coreData.remove(managedObject: contact)
        coreData.commit()
        contacts.remove(at: id)
    }
    
    func getPosition(by contact: Contact) -> Int? {
       return contacts.index(where: {other in return other.name == contact.name })
    }
    
}


