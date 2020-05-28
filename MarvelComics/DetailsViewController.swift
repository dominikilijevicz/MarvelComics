//
//  DetailsViewController.swift
//  MarvelComics
//
//  Created by Dominik on 28/05/2020.
//  Copyright © 2020 Dominik. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    

    @IBOutlet weak var thumbImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var comic: Comic?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        titleLabel.text = comic?.title
        descLabel.text = comic?.desc
        thumbImgView.imageFromURL(urlString: (comic?.imgUrl)!)
        print(comic?.desc)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ViewSegue", sender: self)
    }
    
    
}
