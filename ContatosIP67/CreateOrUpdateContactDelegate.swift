//
//  CreateOrUpdateContactDelegate.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/3/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

protocol CreateOrUpdateContactDelegate{

    func created(contact: Contact)
    func updated(contact: Contact)

}
