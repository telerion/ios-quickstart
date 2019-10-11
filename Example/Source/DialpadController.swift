//
//  DialpadController.swift
//  Example
//
//  Copyright © 2019 Telerion. All rights reserved.
//

import UIKit
import TelerionSDK

class DialpadController: UIViewController {

    var sdk : TSDKCore!
    var session : TSDKSession?
    @IBOutlet weak var ebNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TEMP:
        ebNumber.text = "11"

        // Store SDK
        self.sdk = (UIApplication.shared.delegate as? AppDelegate)!.getSdk()
    }
    
    @IBAction func onAudioCall(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "call") as! CallController
        vc.audioOnly = true
        vc.number = ebNumber.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onChat(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "chat") as! ChatController
        vc.number = ebNumber.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onVideoCall(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "call") as! CallController
        vc.audioOnly = false
        vc.number = ebNumber.text!
        self.present(vc, animated: true, completion: nil)
    }
}
