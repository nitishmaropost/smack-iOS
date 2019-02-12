//
//  ChatVC.swift
//  Smack
//
//  Created by maropost on 24/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var labelChannelName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       // self.labelChannelName.text = "#\(AuthService.instance.selectedChannel)"
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
           self.onLoginGetMessages()
        } else {
            self.labelChannelName.text = "Please login"
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        self.updateChannelName()
    }
    
    func updateChannelName() {
        self.labelChannelName.text = "#\(MessageService.instance.selectedChannel?.name ?? "Smack")"
       // AuthService.instance.selectedChannel = (MessageService.instance.selectedChannel?.name)!
        self.getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                print("success")
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateChannelName()
                } else {
                    self.labelChannelName.text = "No channel yet"
                }
            } else {
                print("fail")
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else {
            return
        }
        
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
    }
}
