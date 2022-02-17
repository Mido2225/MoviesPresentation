//
//  SeatMapController.swift
//  MovieTask
//
//  Created by Mohamed Aglan on 2/16/22.
//

import UIKit

class SeatMapController: BaseVC {
    
    
    //MARK: - IBOutLets -
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var datesCollectionView: UICollectionView!
    @IBOutlet weak var seatsCollectionView: UICollectionView!
    
    //MARK: - Properties -
    private var datesArray = ["5 Mar","6 Mar","7 Mar","8 Mar","9 Mar"] {
        didSet {
            datesCollectionView.reloadData()
        }
    }
    
    
    //MARK: - LifeCycle Events -

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViews()
    }
    

    //MARK: - Custom UI -
    
    
    
    
    
    //MARK: - Business Logic -
    func registerCollectionViews() {
        datesCollectionView.delegate = self
        seatsCollectionView.dataSource = self
        datesCollectionView.delegate = self
        seatsCollectionView.dataSource = self
        
        datesCollectionView.register(cellType: DatesCollectionCell.self, bundle: nil)
        seatsCollectionView.register(cellType: SeatsCollectionCell.self, bundle: nil)
    }
    
    
    
    
    //MARK: - Networking -
    
    
    
    
    
    //MARK: - IBActions -
    
    
    

}


//MARK: - Extensions -


extension SeatMapController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == datesCollectionView {
            return datesArray.count
        }else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == datesCollectionView {
            let item = collectionView.dequeueReusableCell(with: DatesCollectionCell.self, for: indexPath)
            item.dateTitle.text = datesArray[indexPath.row]
            return item
        }else {
            let item = collectionView.dequeueReusableCell(with: SeatsCollectionCell.self, for: indexPath)
            return item
        }
    }
    
    
    
}

extension SeatMapController:UICollectionViewDelegate {
    
    
}

extension SeatMapController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == datesCollectionView {
            return CGSize(width: 65, height: 30)
        }else {
            return CGSize(width: 240, height: 145)
        }
    }
}
