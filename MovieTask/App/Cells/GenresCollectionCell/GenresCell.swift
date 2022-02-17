//
//  GenresCell.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/16/22.
//

import UIKit

class GenresCell: UICollectionViewCell {
    
    //MARK: - IBOutLets -
    
    @IBOutlet weak var genresView: UIView!
    @IBOutlet weak var genresTitle: UILabel!
    
    
    
    
    //MARK: - LifeCycle Events -

    override func awakeFromNib() {
        super.awakeFromNib()
        genresView.layer.cornerRadius = 16
    }

}
