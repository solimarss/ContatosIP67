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
    
    
    let base_api_url = "http://api.openweathermap.org/data/2.5/weather"
    let base_icon_url = "http://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather"
        
        mainLabel.isHidden = true
        minLabel.isHidden = true
        maxLabel.isHidden = true
        
        

        let param = [
            "lat": contact.latitude.description,
            "lon": contact.longitude.description,
            "appid": "e53f5c17b63077c24d8bd1906748394a",
            "units": "metric"
            
        ]
        
        //"lang": "pt"
        
        //Alamofire.request(base_api_url, parameters: param).responseArray { (response: DataResponse<[Weather]>) in
        
        //}
        
        Alamofire.request(base_api_url, parameters: param).responseObject { (response: DataResponse<Weather>) in
         
            guard let weather = response.value else {
                return
            }
            
            self.mainLabel.text = weather.main
            self.minLabel.text = weather.temperature.min.description + " º" //alt+0
            self.maxLabel.text = weather.temperature.max.description + " º" //alt+0
            
            
            
            if let url = URL(string: self.base_icon_url + weather.icon + ".png"){
                self.mainImageView.af_setImage(withURL: url)
            }
            
            
            self.mainLabel.isHidden = false
            self.minLabel.isHidden = false
            self.maxLabel.isHidden = false

            
            
        }
        
    }

   

    
}
