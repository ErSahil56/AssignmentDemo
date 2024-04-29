//
//  DetailViewController.swift
//  PostDemo
//
//  Created by Sahil Garg on 29/04/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    var postModel : PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.numberOfLines = 0
        detailLabel.text = "ID : \(postModel?.id ?? 0) \nUser ID :  \(postModel?.userId ?? 0) \nTitle : \(postModel?.title ?? "") \nBody : \(postModel?.body ?? "")"
    }

}
