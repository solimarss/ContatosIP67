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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
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
    
    
}
