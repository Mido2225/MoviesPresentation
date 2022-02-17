//
//  SearchMoviesController.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/16/22.
//

import UIKit

class SearchMoviesController: BaseVC {
    
    //MARK: - IBOutLets -
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBackGroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties -
    var finalSearchCount:[Result] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    //MARK: - LifeCycle Events -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        handleSearchView()
//        searchApiCall()
//        searchTextField.delegate = self
    }
    
    
    
    //MARK: - Custom UI -
    func handleSearchView() {
        searchBackGroundView.layer.cornerRadius = 30
        searchBackGroundView.clipsToBounds = true
    }
    
    
    
    //MARK: - Business Logic -
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: SearchingCell.self, bundle: nil)
    }
    
    
    
    
    //MARK: - Networking -
    func searchApiCall() {
        APIRouter.search(apiKey: "fae339333791a654dbc35414840b27ed", query: searchTextField.text ?? "").send { [weak self] (respons:SearchModel?, errorType:APIRouter.errors?) in
            guard let self = self else {return}
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
                self.finalSearchCount = response.results
            }
        }
    }
    
    
    
    
    
    //MARK: - IBActions -
    
    @IBAction func existButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        print("TESTING")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.searchApiCall()
//        }
    }
    
    
    
    
}

//MARK: - Extensions -

extension SearchMoviesController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalSearchCount.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Results"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchingCell.self, for: indexPath)
        let model = finalSearchCount[indexPath.row]
        cell.handleShown(data: model)
        return cell
    }
    
    
    
    
}

extension SearchMoviesController: UITableViewDelegate {
    
    
}


//extension SearchMoviesController: UITextFieldDelegate {
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
////        searchApiCall()
//        print("Selected")
//    }
//
//
//}
