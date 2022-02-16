//
//  MovieTableViewCell.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/15/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - IBOutLets -
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    
    
    //MARK: - LifeCycle Events -

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
