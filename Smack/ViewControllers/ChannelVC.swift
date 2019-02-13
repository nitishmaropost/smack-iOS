//
//  ChannelVC.swift
//  Smack
//
//  Created by maropost on 24/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableChannel: UITableView!
    
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableChannel.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableChannel.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            self.loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            self.userImg.image = UIImage(named: UserDataService.instance.avatarName)
            self.userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            self.loginBtn.setTitle("Login", for: .normal)
            self.userImg.image = UIImage(named: "menuProfileIcon")
            self.userImg.backgroundColor = UIColor.clear
            tableChannel.reloadData()
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // Show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            self.present(profile, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func addChannelButton(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            self.present(addChannel, animated: true, completion: nil)
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        self.setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notification: Notification) {
        self.tableChannel.reloadData()
    }
}

extension ChannelVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel._id}
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
}

extension ChannelVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
            
        }
    }
}
