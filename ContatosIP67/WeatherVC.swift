//
//  WheaterVC.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/6/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class WeatherVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    var contact: Contact!
    let api = Api()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather"
        
        mainLabel.isHidden = true
        minLabel.isHidden = true
        maxLabel.isHidden = true
        
        

        
        
        
        api.getWeather(by: contact) { (weather, url ,error) in
            
            guard error == nil else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            guard let weather = weather else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            
            self.mainLabel.text = weather.main
            self.minLabel.text = weather.temperature.min.description + " º" //alt+0
            self.maxLabel.text = weather.temperature.max.description + " º" //alt+0
            
            
            
            if let url = url {
                self.mainImageView.af_setImage(withURL: url)
            }
            
            
            self.mainLabel.isHidden = false
            self.minLabel.isHidden = false
            self.maxLabel.isHidden = false
            
            
        }
            
        

            
            
      
        
    }

   

    
}
