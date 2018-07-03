//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtFone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtSite: UITextField!
    
    var contact: Contact?
    var delegate: CreateOrUpdateContactDelegate?
    
    let dao = ContactDAO.shared
    var isNew = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = self.contact {
            fillForm(with: contact)
            isNew = false
        }else{
            contact = Contact()
        }
    }
    
    private func fillForm(with contact: Contact){
        txtNome.text = contact.name
        txtEndereco.text = contact.address
        txtSite.text = contact.site
        txtFone.text = contact.phone
    }
    
    private func fillContact(){
        contact?.name = txtNome.text!
        contact?.phone = txtFone.text!
        contact?.address = txtEndereco.text!
        contact?.site = txtSite.text!    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        
        fillContact()
        
        if isNew {
            dao.add(newContact: contact!)
            delegate?.created(contact: contact!)
        }else{
            delegate?.updated(contact: contact!)
        }
        _ = navigationController?.popViewController(animated: true)// _ = ignora o retorno
        
    }
    
    
    
}

