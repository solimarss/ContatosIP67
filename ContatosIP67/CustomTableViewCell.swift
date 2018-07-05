//
//  CustomTableViewCell.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/4/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //profileImageView.layer.cornerRadius = profileImageView.layer.bounds.height / 2
        profileImageView.layer.cornerRadius = profileImageView.constraints[0].constant / 2

        profileImageView.clipsToBounds = true
        
        print("XXXXX")
        print(profileImageView.layer.bounds.height)
        print(profileImageView.layer.bounds.width)
        print(profileImageView.frame.size.height)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
