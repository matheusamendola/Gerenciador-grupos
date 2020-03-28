//
//  GroupsTableViewCell.swift
//  InovaGroups
//
//  Created by Matheus Amendola on 28/03/20.
//  Copyright © 2020 Matheus Amendola. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbGroup: UILabel!
    @IBOutlet weak var lbLeader: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbGroupMembers: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
