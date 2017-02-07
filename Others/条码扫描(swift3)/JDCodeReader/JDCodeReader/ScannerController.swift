//
//  ScannerController.swift
//  JDCodeReader
//
//  Created by LuoLiu on 17/1/19.
//  Copyright © 2017年 LuoLiu. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

    //    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeUPCECode,
                                                         AVMetadataObjectTypeCode39Code,
                                                         AVMetadataObjectTypeCode39Mod43Code,
                                                         AVMetadataObjectTypeEAN13Code,
                                                         AVMetadataObjectTypeEAN8Code,
                                                         AVMetadataObjectTypeCode93Code,
                                                         AVMetadataObjectTypeCode128Code,
                                                         AVMetadataObjectTypePDF417Code,
                                                         AVMetadataObjectTypeQRCode,
                                                         AVMetadataObjectTypeAztecCode,
                                                         AVMetadataObjectTypeInterleaved2of5Code,
                                                         AVMetadataObjectTypeITF14Code,
                                                         AVMetadataObjectTypeDataMatrixCode]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
            //            qrCodeFrameView = UIView()
            //            if let qrCodeFrameView = qrCodeFrameView {
            //                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            //                qrCodeFrameView.layer.borderWidth = 3
            //                view.addSubview(qrCodeFrameView)
            //                view.bringSubview(toFront: qrCodeFrameView)
            //            }
            
        } catch {
            
            print(error)
            return
            
        }
        
        view.bringSubview(toFront: messageLabel)
        view.bringSubview(toFront: topbar)
    }
    
    @IBAction func swapCamera(_ sender: Any) {
        
        if captureDevice?.position == .back {
            if let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) {
                for device in videoDevices {
                    if let device = device as? AVCaptureDevice {
                        if device.position == .front {
                            captureDevice = device
                            break
                        }
                    }
                }
            }
        } else {
            captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        }
        
        self.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        guard metadataObjects.isEmpty == false else {
            //            qrCodeFrameView?.frame = .zero
            messageLabel.text = "No Code is detected"
            return
        }
        
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        if metadataObj.stringValue != nil {
            if metadataObj.type == AVMetadataObjectTypeQRCode {
                if let url = URL(string: metadataObj.stringValue) {
                    UIApplication.shared.openURL(url)
                    return
                }
            }
            
            messageLabel.text = metadataObj.stringValue
            let alert = UIAlertController(title: "", message: metadataObj.stringValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.messageLabel.text = "No Code is detected"
                self.captureSession?.startRunning()
            }))
            self.present(alert, animated: true, completion: nil)
            captureSession?.stopRunning()
            print(metadataObj.stringValue)
        }
    }
}
