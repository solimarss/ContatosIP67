//
//  ContactsListVC.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ContactsListVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let dao = ContactDAO.shared
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        //Exemplo de i18n
        let save = NSLocalizedString("save", comment: "comentario")
        print(save)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(actionSheet(gesture:)))
        tableview.addGestureRecognizer(longPress)
        
        
        
    }
    
    func actionSheet(gesture: UIGestureRecognizer){
        
        guard gesture.state == .began else {
            return
        }
        
        let point = gesture.location(in: tableview)
        
        guard let indexPath = tableview.indexPathForRow(at: point) else {
            return
        }
        
        let contact = dao.findBy(position: indexPath.row)
        
        ActionManager(presentIn: self).showActions(of: contact)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = selectedIndexPath {
            tableview.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            
            //executa esse codigo apos 2 segundos na thred principal
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.tableview.deselectRow(at: indexPath, animated: true)
                self.selectedIndexPath = nil
            })
            
            
        }
    }
    
}

extension ContactsListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell_ID", for: indexPath)
        
        let contact = dao.findBy(position: indexPath.row)
        print("position: \(indexPath.row)")
        cell.textLabel?.text = "Nome: \(contact.name!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Cuidado", message: "Deseja relamente excluir?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            
            let removeAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) in
                self.dao.remove(byId: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .fade)
            })
            
            alert.addAction(cancelAction)
            alert.addAction(removeAction)
            
            present(alert, animated: true, completion: nil)
            
           
        }
        
    }
    
}

extension ContactsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = dao.findBy(position: indexPath.row)
        print(contact)
        
        performSegue(withIdentifier: "toUpdate", sender: contact)
        /**
 
        if let form = storyboard?.instantiateViewController(withIdentifier: "cadastro_id")  as? ViewController   {
            form.contact = contact
           navigationController?.pushViewController(form, animated: true)
        }
       **/
    }
    
}

extension ContactsListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         let form = segue.destination as? ViewController
                 form?.delegate = self
        
        if segue.identifier == "toUpdate"
        {
         
          let contact = sender as? Contact
          form?.contact = contact

            
        }
        
        if segue.identifier == "toInsert"
        {
           print("toInsert")
            
        }
    }
    
   
}

extension ContactsListVC: CreateOrUpdateContactDelegate{
    func created(contact: Contact) {
        if let row = dao.getPosition(by: contact){
            selectedIndexPath = IndexPath(row: row, section: 0)
            
        }
        
    }
    
    func updated(contact: Contact) {
        
        if let row = dao.getPosition(by: contact){
            selectedIndexPath = IndexPath(row: row, section: 0)
            
        }
    }
}


