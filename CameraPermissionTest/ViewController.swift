//
//  ViewController.swift
//  CameraPermissionTest
//
//  Created by Rakesh Yadav on 17/01/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var openCamera: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCameraButtonClick(_ sender: Any) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
            if granted {
                DispatchQueue.main.async {
                    self.showCamera()
                }
                
            } else {
                let alertBox: UIAlertController = UIAlertController(title: "Camera Permission", message: "Camera permission absolutly required to run the app", preferredStyle: .alert)
                alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    if let url: URL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }))
                alertBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertBox, animated: true, completion: nil)
                }
            }
        }
    }
    
    func showCamera() {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    
}

