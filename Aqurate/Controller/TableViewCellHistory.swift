//
//  TableViewCellHistory.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 16/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class TableViewCellHistory: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMode: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
