//
//  CustomTableViewCell.swift
//  PostDemo
//
//  Created by Sahil Garg on 29/04/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    var cellModel : PostModel? {
        didSet {
            if let model = cellModel {
                lblId.text = "\(model.id)."
                lblTitle.text = model.title
            }
        }
    }
    
}
