//
//  Api.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/6/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias WeatherResponse = (Weather?, URL? ,Error?) -> Void

class Api {
    
    let base_api_url = "http://api.openweathermap.org/data/2.5/weather"
    let base_icon_url = "http://openweathermap.org/img/w/"
    
    
    func getWeather (by contact: Contact, response: @escaping WeatherResponse){
        
        
        let param = [
            "lat": contact.latitude.description,
            "lon": contact.longitude.description,
            "appid": "e53f5c17b63077c24d8bd1906748394a",
            "units": "metric"
            
        ]
        
        //"lang": "pt"
        
        //Alamofire.request(base_api_url, parameters: param).responseArray { (response: DataResponse<[Weather]>) in
        
        //}
        
        Alamofire.request(base_api_url, parameters: param).responseObject { (result: DataResponse<Weather>) in
            
            guard let weather = result.value else {
                response(nil, nil, result.error)
                return
           }
            
            let url = URL(string: self.base_icon_url + weather.icon + ".png")
            
            response(weather, url, nil)
            
        }
        
        
    }
    
    
    
    
}
