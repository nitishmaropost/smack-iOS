//
//  MessageService.swift
//  Smack
//
//  Created by maropost on 07/02/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_BEARER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                
                print(self.channels)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
