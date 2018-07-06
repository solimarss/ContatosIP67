//
//  ActionManager.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/4/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import CoreLocation


class ActionManager {
    
    let controller: UIViewController
    
    init(presentIn controller: UIViewController) {
        self.controller = controller
        
    }
    
    func showActions(of contact: Contact) {
        let alert = UIAlertController(title: "Choose one action", message: contact.name, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let call = UIAlertAction(title: "Call", style: .default) { action in
            self.call(phone: contact.phone)
        }
        let browser = UIAlertAction(title: "Open in Browser", style: .default) { action in
            self.browser(site: contact.site)
        }
        let maps = UIAlertAction(title: "Show in Map", style: .default) { action in
            self.maps(address: contact.address)
        }
        let weather = UIAlertAction(title: "Show Weather", style: .default) { action in
            self.navigationToWeatherView(with: contact)
        }
        
        alert.addAction(cancel)
        alert.addAction(call)
        alert.addAction(browser)
        alert.addAction(maps)
        
        if CLLocationCoordinate2DIsValid(contact.coordinate)   {
            alert.addAction(weather)
        }
        
        
        
        controller.present(alert, animated: true, completion: nil)

    }
    
    
    private func navigationToWeatherView(with contact: Contact){
        /** Navegacao usando navigationController
        guard let viewController =   controller.storyboard?.instantiateViewController(withIdentifier: "weatherID") else {
            return
        }
        
        guard let weatherController = viewController as? WeatherVC else {
             return
        }
        
        weatherController.contact = contact
        
        controller.navigationController?.pushViewController(weatherController, animated: true)
        
 **/
        //Navegacao via segue
            controller.performSegue(withIdentifier: "weatherSegueID", sender: contact)
        
        
        
    }
    
    private func openApp(by url: String){
        
        guard let appUrl = URL(string: url) else {
            return
        }
        
        //Eh possivel verificar se eh possivel abrir a url antes de abri-la de fato
        //UIApplication.shared.canOpenURL(<#T##url: URL##URL#>)
        
        UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        
    }
    
    private func call (phone: String){
        if UIDevice.current.userInterfaceIdiom == .phone {
            openApp(by: "tel:"+phone)
        }else{
            let alert = UIAlertController(title: "Sorry", message: "You can't call", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Back", style: .cancel, handler: nil)
            alert.addAction(cancel)
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func browser (site: String){
        if(site.hasPrefix("http:")){
            openApp(by: site)
        }else{
            openApp(by: "http:"+site)
        }
    }
    
    private func maps (address: String){
        /** abre o mapa no browser
        guard let url = "http://maps.google.com/maps?q=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        **/
        
        guard let url = "maps://?q=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return
        }

        
        openApp(by: url)
        
    }
}
