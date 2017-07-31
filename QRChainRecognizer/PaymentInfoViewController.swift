//
//  PaymentInfoViewController.swift
//  QRChainRecognizer
//
//  Created by Artur Guseinov on 30/07/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import AVFoundation

class PaymentInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var paymentIdLabel: UILabel!
    
    var paymentInfo: PaymentInfo!
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = paymentInfo.avatar
        nicknameLabel.text = "Nickname: " + paymentInfo.nickname
        paymentIdLabel.text = "Payment ID: " + paymentInfo.paymentId
        
        let audioFilePath = Bundle.main.path(forResource: "lesh", ofType: "mp3")
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
        audioPlayer = try! AVAudioPlayer(contentsOf: audioFileUrl)
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
