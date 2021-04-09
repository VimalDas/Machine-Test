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
    
    var showDetails: ShowListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchShowDetails()
    }
    
    func fetchShowDetails() {
        ApiManager.shared.singleShow(showId: "1") { result in
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

    func updateUI() {
        showDetailImageView.imageFromUrl(urlString: showDetails?.image.original ?? "")
        showDescriptionLabel.text = showDetails?.summary
        showStatusLabel.text = showDetails?.status
        showDateLabel.text = showDetails?.premiered
        showRunTimeLabel.text = "\(showDetails?.runtime)"
        showOfficialSiteLabel.text = showDetails?.officialSite
        showUrlLabel.text = showDetails?.url
        showRatingLabel.text = "\(showDetails?.rating.average)"
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowListCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}

extension ShowDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
