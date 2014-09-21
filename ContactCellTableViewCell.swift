//
//  ContactCellTableViewCell.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/3/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class ContactCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! = UILabel()
    @IBOutlet weak var phoneLabel: UILabel! = UILabel()
    @IBOutlet weak var emailLabel: UILabel! = UILabel()
    @IBOutlet weak var contactImageView: UIImageView! = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
