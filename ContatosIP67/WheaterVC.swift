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

class WheaterVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    let base_api_url = "http://api.openweathermap.org/data/2.5/weather"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let param = [
            "lat": "-23.588453",
            "lon": "-46.632103",
            "appid": "e53f5c17b63077c24d8bd1906748394a",
            "units": "metric"
        ]
        
        //Alamofire.request(base_api_url, parameters: param).responseArray { (response: DataResponse<[Weather]>) in
        
        //}
        
        Alamofire.request(base_api_url, parameters: param).responseObject { (response: DataResponse<Weather>) in
         
            guard let weather = response.value else {
                return
            }
            
            self.mainLabel.text = weather.main
            self.minLabel.text = weather.temperature.min.description + "º" //alt+0
            self.maxLabel.text = weather.temperature.max.description + "º" //alt+0
            
            
            
            
        }
        
    }

   

    
}
