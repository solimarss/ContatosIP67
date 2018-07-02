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
    
   let dao = ContactDAO.shared    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveNewContact(_ sender: UIBarButtonItem) {
        
        let contact = Contact()
        
        contact.name = txtNome.text!
        contact.phone = txtFone.text!
        contact.address = txtEndereco.text!
        contact.site = txtSite.text!
        print(contact)
        
        dao.add(newContact: contact)
        
        _ = navigationController?.popViewController(animated: true)// _ = ignora o retorno
        
    }
    
    
    
}

