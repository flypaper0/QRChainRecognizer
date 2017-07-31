//
//  CameraManager.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 28/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import AVFoundation

class CameraManager {
    
    static func requestAccessIfNeeded(failure: VoidBlock?, completion: VoidBlock?) {
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
            completion?()
        } else {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    completion?()
                } else {
                    failure?()
                }
            })
        }
    }

}
