//
//  ViewController.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/15/22.
//

import UIKit

class WatchTabController: BaseVC {
    
    
    //MARK: - IBOutLets -
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    //MARK: - Properties -
    private var moviesArray:[MoviesResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    
    
    
    //MARK: - LifeCycle Events -

    override func viewDidLoad() {
        super.viewDidLoad()
        upComingMoviesApiCall()
        registerTableView()
    }
    
    
    
    //MARK: - Custom UI -
    
    
    
    
    
    //MARK: - Business Logic -
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: WatchMoviesTabCell.self, bundle: nil)
        tableView.separatorStyle = .none
    }
    
    
    
    
    //MARK: - Networking -
    private func upComingMoviesApiCall() {
        self.showIndicator()
        APIRouter.upComingMovies(apiKey: "fae339333791a654dbc35414840b27ed").send { [weak self] (respons:UpComingMoviesModel?, errorType:APIRouter.errors?) in
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
                self.moviesArray = response.results
            }
        }
    }
    
    
    
    
    
    
    
    //MARK: - IBActions -
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        let vc = AppStoryboards.search.instantiate(SearchMoviesController.self)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    


}


//MARK: - Extensions -
extension WatchTabController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: WatchMoviesTabCell.self, for: indexPath)
        cell.moviePoster.setWith(url: "https://image.tmdb.org/t/p/w500"+moviesArray[indexPath.row].posterPath)
        cell.movieName.text = moviesArray[indexPath.row].originalTitle
        return cell
    }
    

    
    
}


extension WatchTabController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppStoryboards.search.instantiate(MovieDetailsController.self)
        vc.movieId = moviesArray[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}

