//
//  ViewController.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import UIKit

class ShowListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var shows: [ShowListModel] = []
    var filteredResults: [ShowListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showList()
    }

    func showList() {
        ApiManager.shared.call(type: .showList, model: [ShowListModel].self) { (result) in
            
            switch result {
            case .success(let dataArr):
                self.shows = dataArr
                self.collectionView.reloadData()
                
            case .failure(_):
                break
            }
            
        }
    }
    
    func filterShows(searchKey: String) {
        ApiManager.shared.call(type: .showSearch(searchKey), model: [ShowListModel].self) { (result) in
            switch result {
            case .success(let dataArr):
                self.shows = dataArr
                self.collectionView.reloadData()
                
            case .failure(_):
                break
            }

        }
    }

}

extension ShowListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let showDetails = shows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowListCollectionViewCell.identifier, for: indexPath) as! ShowListCollectionViewCell
        cell.showTitleImageView.imageFromUrl(urlString: showDetails.image?.medium ?? "")
        cell.showTitleLabel.text = showDetails.name
        return cell
    }
    
    
}

extension ShowListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

extension ShowListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        let height = (collectionView.frame.height - 16) / 2.5
        return CGSize(width: width, height: height)
    }
}

extension ShowListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty  {
            showList()
        } else {
            filterShows(searchKey: searchText)
        }
    }
}

