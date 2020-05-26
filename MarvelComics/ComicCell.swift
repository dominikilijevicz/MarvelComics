//
//  ComicCell.swift
//  MarvelComics
//
//  Created by Dominik on 26/05/2020.
//  Copyright © 2020 Dominik. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

        
    @IBOutlet weak var dateOnSale: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
