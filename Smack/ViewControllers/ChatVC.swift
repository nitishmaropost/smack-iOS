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
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tableChat: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        self.view.addGestureRecognizer(tap)
        self.tableChat.estimatedRowHeight = 80
        self.tableChat.rowHeight = UITableViewAutomaticDimension
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
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
    @IBAction func buttonSendMessage(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else {
                return
            }
            
            guard let messageBody = txtMessage.text else {
                return
            }
            
            SocketService.instance.addMessage(messageBody: messageBody, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.txtMessage.text = ""
                    self.txtMessage.resignFirstResponder()
                }
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
            if success {
                self.tableChat.reloadData()
            }
        }
    }
}

extension ChatVC: UITableViewDelegate {
    
}

extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
