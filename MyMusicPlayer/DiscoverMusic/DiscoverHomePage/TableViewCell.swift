//
//  TableViewCell.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/14.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    @IBOutlet weak var songIcon: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songDetailTitle: UILabel!
    
    var songIconUrl :String?{
        didSet{
            songIcon.kf.setImage(with: URL(string: songIconUrl ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
