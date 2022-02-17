//
//  SeatsCollectionCell.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/17/22.
//

import UIKit

class SeatsCollectionCell: UICollectionViewCell {
    
    //MARK: - IBOutLets -
    @IBOutlet weak var backGroundview: UIView!
    @IBOutlet weak var seatsImages: UIImageView!
    
    
    
    //MARK: - LifeCycle Events -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundview.layer.cornerRadius = 8
        backGroundview.layer.borderWidth = 1
        backGroundview.layer.borderColor = UIColor(named: "Blue")?.cgColor
    }

}
