//
//  ViewController.swift
//  Example
//
//  Copyright © 2019 Telerion. All rights reserved.
//

import UIKit
import TelerionSDK

class LoginController: UIViewController {
    
    var sdk : TSDKCore!
    @IBOutlet weak var btUrl: UITextField!
    @IBOutlet weak var btLogin: UITextField!
    @IBOutlet weak var btPass: UITextField!
    @IBOutlet weak var lbError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set defaults
        //btUrl.text = "ws://192.168.1.200:8888/"
        btUrl.text = "wss://rtcdev.telerion.com/rtc-ws"
        //btLogin.text = "admin@root"
        btLogin.text = "7b8ad92a-0046-4a66-96e9-9cb05f6dedaa"
        btPass.text = "newnew"
    }
    
    private func onLoginOk() {
        
        // Go to dialpad view
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "dialpad") as! DialpadController
        self.present(vc, animated: true, completion: nil)
    }
    
    private func onLoginFail(_ error : TSDKError?) {
        lbError.text = error?.reason
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        // Prepare SDK
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.initSdk(btUrl.text!)
        self.sdk = appDlg?.getSdk()
        self.sdk.onLogin = onLoginOk
        self.sdk.onLogout = onLoginFail
        
        // Login as account
        //sdk.login(login: btLogin.text!, password: btPass.text!)
        
        // Login as widget
        sdk.login(widgetId: UUID(uuidString: btLogin.text!)!)
    }
}
