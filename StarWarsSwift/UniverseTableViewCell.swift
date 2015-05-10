//
//  UniverseTableViewCell.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 10/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import UIKit

class UniverseTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var aliasView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
