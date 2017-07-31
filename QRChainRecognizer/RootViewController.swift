//
//  RootViewController.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import AVFoundation

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func showAccessRequiredAlert() {
        let alert = UIAlertController(title: "Error", message: "You can allow the application to use the camera in Settings", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func showRecognitioViewController() {
        performSegue(withIdentifier: "showRecognizeViewController", sender: nil)
    }

    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showSendViewController", sender: nil)
    }

    @IBAction func recognizeButtonPressed(_ sender: UIButton) {
        CameraManager.requestAccessIfNeeded(failure: { [weak self] in
            self?.showAccessRequiredAlert()
        }) { [weak self] in
            self?.showRecognitioViewController()
        }
    }
}
