//
//  ListTableViewCell.swift
//  ContactU
//
//  Created by MARCIO DASILVA on 8/9/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel! = UILabel()
    
    @IBOutlet var titleLabel: UILabel! = UILabel()
    
    @IBOutlet var dueDateLabel: UILabel! = UILabel()
    
    @IBOutlet var contactImageView: UIImageView! = UIImageView()
    
    
    @IBOutlet var callButton: UIButton! = UIButton()
    @IBOutlet var textButton: UIButton! = UIButton()
    @IBOutlet var mailButton: UIButton! = UIButton()
    
    //----------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
