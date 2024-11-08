//
//  DetailViewController.swift
//  Sneakers
//
//  Created by Quick tech  on 08/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var productResponse: ProductData?
    
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstProduct = productResponse {
            lbl.text = firstProduct.description
        }
    }

}
