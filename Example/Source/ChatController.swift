//
//  ChatController.swift
//  Example
//
//  Copyright © 2019 Telerion. All rights reserved.
//

import UIKit
import TelerionSDK

class ChatController: UIViewController {

    
    @IBOutlet weak var chatView: UITextView!
    @IBOutlet weak var enteredMsg: UITextField!
    var number : String = ""
    var sdk : TSDKCore!
    var session : TSDKSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Store SDK
        self.sdk = (UIApplication.shared.delegate as? AppDelegate)!.getSdk()
        
        // Create session
        self.session = self.sdk.createSession(.chat)
        self.session!.onDisconnect = onDisconnect
        self.session!.onConnect = onConnect
        self.session!.onMessage = onMessage
        self.session!.connect(self.number)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
                                               
    }
    
    @objc private func keyboardWillShow(notification : Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.view.frame.size.height -= keyboardFrame.height
    }
    
    @objc private func keyboardWillHide(notification : Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.view.frame.size.height += keyboardFrame.height
    }
   
    private func onDisconnect(error : TSDKError?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func onConnect() {
    }
    
    private func onMessage(msg : TSDKChatMessage) {
        if msg.incoming {
            chatView.text += "\n << " + msg.message
        }
    }
    
    @IBAction func onLeaveRoom(_ sender: UIButton) {
        self.session?.disconnect()
        self.session = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSendMessage(_ sender: UIButton) {
        guard let text = enteredMsg.text else { return }
        if !text.isEmpty {
            self.session?.sendMessage(enteredMsg.text!)
            chatView.text += "\n >> " + text
            enteredMsg.text = ""
        }
    }
}
