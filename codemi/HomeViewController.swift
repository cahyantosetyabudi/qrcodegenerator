//
//  HomeViewController.swift
//  codemi
//
//  Created by Cahyanto Setya Budi on 12/20/18.
//  Copyright © 2018 Cahyanto Setya Budi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var qrImageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let QRCode = generateQRCode(from: "Cahyanto Setya Budi")
        qrImageView.image = QRCode
        
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let transformedImage = filter?.outputImage?.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
        return UIImage(ciImage: transformedImage!)
    }
    
}
