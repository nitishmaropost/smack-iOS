//
//  ChannelCell.swift
//  Smack
//
//  Created by maropost on 11/02/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    
    @IBOutlet weak var channelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel: Channel) {
        self.channelTitle.text = "#\(channel.name ?? "")"
        channelTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        for id in MessageService.instance.unreadChannels {
            if id == channel._id {
                channelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
    }
}
