//
//  ResultsTableViewCell.swift
//  Roadtrip
//
//  Created by Shannon Brown on 2020-11-25.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var resultsImage: UIImageView!
    @IBOutlet weak var resultsCityLabel: UILabel!
    @IBOutlet weak var resultsDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
