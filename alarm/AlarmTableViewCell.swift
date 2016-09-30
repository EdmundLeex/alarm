//
//  AlarmTableViewCell.swift
//  alarm
//
//  Created by edmund on 9/27/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
