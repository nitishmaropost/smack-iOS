//
//  SocketService.swift
//  Smack
//
//  Created by maropost on 11/02/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    var manager: SocketManager
    var socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = self.manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        self.socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        self.socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {
                return
            }
            
            guard let channelDesc = dataArray[1] as? String else {
                return
            }
            
            guard let channelId = dataArray[2] as? String else {
                return
            }
            
            let newChannel = Channel(_id: channelId, name: channelName, description: channelDesc, __v: 0)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
}
