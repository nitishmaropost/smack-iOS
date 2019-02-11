//
//  Channel.swift
//  Smack
//
//  Created by maropost on 07/02/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int?
}
