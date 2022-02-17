//
//  MovieDetailsController.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/16/22.
//

import UIKit

class MovieDetailsController: BaseVC {
    
    
    //MARK: - IBOutLets -
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var getTicketsBtn: UIButton!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieOverView: UITextView!
    
    
    
    
    //MARK: - Properties -
    var movieId:Int!
    private var genres:[Genre] = [] {
        didSet {
            genresCollectionView.reloadData()
        }
    }
    
    
    
    //MARK: - LifeCycle Events -

    override func viewDidLoad() {
        super.viewDidLoad()
        editButtonsUI()
        registerCollectionCell()
        guard let movieId = movieId else {fatalError()}
        movieDetailsApiCall(movieID:"\(movieId)")
    }
    
    
    //MARK: - Custom UI -
    func editButtonsUI() {
        watchTrailerButton.layer.borderColor = UIColor(named: "Blue")?.cgColor
        watchTrailerButton.layer.borderWidth = 1
        watchTrailerButton.layer.cornerRadius = 6
        getTicketsBtn.layer.cornerRadius = 6
    }
    
    
    
    
    //MARK: - Business Logic -
    func registerCollectionCell() {
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
        genresCollectionView.register(cellType: GenresCell.self, bundle: nil)
    }
    
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat.random(in: 0...1)
        let greenValue = CGFloat.random(in: 0...1)
        let blueValue = CGFloat.random(in: 0...1)
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        return randomColor
    }
    
    
    
    
    //MARK: - Networking -
    func movieDetailsApiCall(movieID:String) {
        self.showIndicator()
        APIRouter.movieDetails(movieId: movieID,apiKey:"fae339333791a654dbc35414840b27ed").send { [weak self] (respons:MovieDeialsModel?, errorType:APIRouter.errors?) in
            guard let self = self else {return}
            self.hideIndicator()
            if let errorType = errorType {
                switch errorType {
                case .connectionError:
                    self.showErrorAlert(error: "Connection Error")
                case .canNotDecodeData:
                    self.showErrorAlert(error: "canNotDecodeData")
                }
                return
            }
            if let response = respons {
                print(response)
                self.genres = response.genres
                self.moviePoster.setWith(url: "https://image.tmdb.org/t/p/w500" + response.posterPath)
                self.movieName.text = response.originalTitle
                self.movieDate.text = "\(response.popularity)"
                self.movieOverView.text = response.overview
            }
        }
    }
    
    
    
    
    
    
    //MARK: - IBActions -
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func gitTicketsButton(_ sender: UIButton) {
        let vc = AppStoryboards.search.instantiate(FinalSearchResultsController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func watchTrailerPressed(_ sender: UIButton) {
        
        
    }
    
    
}


//MARK: - Ectensions -

extension MovieDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(with: GenresCell.self, for: indexPath)
        item.genresTitle.text = genres[indexPath.row].name
        item.genresView.backgroundColor = generateRandomColor()
        return item
    }
    
    
    
}


extension MovieDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 40)
    }
    
}
