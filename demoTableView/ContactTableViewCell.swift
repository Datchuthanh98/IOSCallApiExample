//
//  ProductTableViewCell.swift
//  demoTableView
//
//  Created by Chu Thanh Dat on 8/26/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
