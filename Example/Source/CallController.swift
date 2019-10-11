//
//  CallController.swift
//  Example
//
//  Copyright © 2019 Telerion. All rights reserved.
//

import UIKit
import TelerionSDK

class CallController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    var audioOnly : Bool = true
    var number : String = ""
    var sdk : TSDKCore!
    var session : TSDKSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Store SDK
        self.sdk = (UIApplication.shared.delegate as? AppDelegate)!.getSdk()
        
        // Create session
        self.session = self.sdk.createSession(.call)
        self.session!.onDisconnect = onDisconnect
        self.session!.onConnect = onConnect
        self.session!.videoEnabled = !self.audioOnly
        self.session!.connect(self.number)
    }
    
    private func onDisconnect(error : TSDKError?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func onConnect() {
        self.session?.setRemoteVideoView(self.videoView)
    }
    
    @IBAction func onBtHangup(_ sender: UIButton) {
        self.session?.disconnect()
        self.session = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onBtSwitchCamera(_ sender: UIButton) {
        self.session?.switchCamera()
    }
}
