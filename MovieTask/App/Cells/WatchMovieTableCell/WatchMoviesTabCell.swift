//
//  WatchMoviesTabCell.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/16/22.
//

import UIKit

class WatchMoviesTabCell: UITableViewCell {
    
    //MARK: - IBOutLets -
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    
    //MARK: - LifeCycle Events -

    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.layer.cornerRadius = 8
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
