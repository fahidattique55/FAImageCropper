//
//  FADetailVC.swift
//  FAImageCropper
//
//  Created by Fahid Attique on 14/02/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class FADetailVC: UIViewController {

    
    // MARK: IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: Public Properties
    
    var croppedImage:UIImage!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewConfigurations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Private Functions
    
    private func viewConfigurations(){
        imageView.image = croppedImage
    }
}
