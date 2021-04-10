//
//  ShowDetailsViewController.swift
//  MachineTest_vimal
//
//  Created by Vimal Das on 09/04/21.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    
    @IBOutlet weak var showDetailImageView: UIImageView!
    @IBOutlet weak var showDescriptionLabel: UILabel!
    @IBOutlet weak var showStatusLabel: UILabel!
    @IBOutlet weak var showDateLabel: UILabel!
    @IBOutlet weak var showRunTimeLabel: UILabel!
    @IBOutlet weak var showOfficialSiteLabel: UILabel!
    @IBOutlet weak var showUrlLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var showDetails: ShowListModel?
    var showSeasonDetails: [ShowListModel] = []
    
    @IBAction func backButtonAction(sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchShowDetails(showId: "1")
        fetchShowSeasonDetails(showId: "1")
    }
    
    func fetchShowDetails(showId: String) {
        ApiManager.shared.call(type: .singleShow(showId), model: ShowListModel.self) { result in
            switch result {
            case .success(let details):
                self.showDetails = details
                self.updateUI()
                break
                
            case .failure(_):
                break
            }
            
        }
    }
    
    func fetchShowSeasonDetails(showId: String) {
        ApiManager.shared.call(type: .showSeason(showId), model: [ShowListModel].self) { result in
            switch result {
            case .success(let details):
                self.showSeasonDetails = details
                self.collectionView.reloadData()
                break
                
            case .failure(_):
                break
            }
            
        }
    }

    func updateUI() {
        showDetailImageView.imageFromUrl(urlString: showDetails?.image?.original ?? "")
        showDescriptionLabel.text = showDetails?.summary
        showStatusLabel.text = showDetails?.status
        showDateLabel.text = showDetails?.premiered
        showRunTimeLabel.text = "\(showDetails?.runtime ?? 0)"
        showOfficialSiteLabel.text = showDetails?.officialSite
        showUrlLabel.text = showDetails?.url
        showRatingLabel.text = "\(showDetails?.rating?.average ?? 0)"
        bgImageView.imageFromUrl(urlString: showDetails?.image?.original ?? "")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShowDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showSeasonDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowDetailsCollectionViewCell.identifier, for: indexPath) as! ShowDetailsCollectionViewCell
        cell.showSeasonLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
}

extension ShowDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
