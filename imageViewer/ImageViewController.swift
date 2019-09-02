//
//  ImageViewController.swift
//  imageViewer
//
//  Created by Fedor Lvov on 02/09/2019.
//  Copyright © 2019 Fedor Lvov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewer: UIImageView!
    var image: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewer.load(image)
    }

}
