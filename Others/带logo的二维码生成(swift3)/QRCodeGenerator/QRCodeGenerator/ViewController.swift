//
//  ViewController.swift
//  QRCodeGenerator
//
//  Created by LuoLiu on 17/2/7.
//  Copyright © 2017年 Fenrir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var qrcodeImage: CIImage!
    @IBOutlet var qrtext: UITextField!
    @IBOutlet var imgQRCode: UIImageView!

    @IBAction func displayQRCode(_ sender: Any) {
        
        if qrcodeImage == nil {
            if qrtext.text == "" {
                return
            }
            
            let data = qrtext.text!.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                //L7% M15% Q25% H%30% 纠错级别. 默认值是M
                filter.setValue("Q", forKey: "inputCorrectionLevel")
                qrcodeImage = filter.outputImage
                qrtext.resignFirstResponder()
                displayQRCodeImage()
            }
            
        }
        else {
            self.imgQRCode.image = nil
            self.qrcodeImage = nil
        }
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        let codeImage = UIImage(ciImage: transformedImage)
        let logoImage = UIImage(named: "ali")!

        imgQRCode.image = codeImage
        generateCodeWithImage(logoImage: logoImage, inImgView: imgQRCode)
    }
    
    func generateCodeWithImage(logoImage: UIImage, inImgView imageView: UIImageView) {
       
        let bounds = imageView.bounds
        
        let size = CGSize(width: bounds.width/4, height: bounds.height/4)
        let centerRect = CGRect(origin: CGPoint(x: bounds.width/2-size.width/2, y: bounds.height/2-size.height/2), size: size)
        let logoImgView = UIImageView(frame: centerRect)
        logoImgView.layer.masksToBounds = false
        logoImgView.clipsToBounds = true
        logoImgView.contentMode = .scaleAspectFill
        logoImgView.layer.borderColor = UIColor.lightGray.cgColor
        logoImgView.layer.borderWidth = 1.0
        logoImgView.layer.cornerRadius = size.width/2
        logoImgView.image = logoImage
        
        imageView.addSubview(logoImgView)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
