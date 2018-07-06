//
//  Wheater.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/6/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import ObjectMapper


class Weather: Mappable {
    
    var temperature: Temperature!
    var main: String!
    var icon: String!
    
    
    
    required init? (map: Map){
        
    }
    
    func mapping(map: Map) {
        temperature <- map["main"]
        main <- map["weather.0.main"]
        icon <- map["weather.0.icon"]
        
    }
    
}

class Temperature: Mappable {
    var min: Double!
    var max:Double!
    
    
    required init? (map: Map){
        
    }
    func mapping(map: Map) {
        
        min <- map["temp_min"]
        max <- map["temp_max"]
        
    }
    
}




