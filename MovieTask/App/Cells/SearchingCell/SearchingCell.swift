//
//  SearchingCell.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/17/22.
//

import UIKit

class SearchingCell: UITableViewCell {
    
    //MARK: - IBOutLets -
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    
    
    //MARK: - Properties -
    var poster:String?
    var title:String?
    var category:String?
    
    
    
    //MARK: - LifeCycle Events -

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func handleShown(data: Result) {
        movieTitle.text = data.originalTitle
        movieCategory.text = data.releaseDate
        moviePoster.setWith(url: "https://image.tmdb.org/t/p/w500"+data.posterPath)
    }
    
}
