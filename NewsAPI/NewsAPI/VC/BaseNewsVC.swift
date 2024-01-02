//
//  BaseNewsVC.swift
//  NewsAPI
//
//  Created by Katerina on 25/12/2023.
//

import Foundation
import UIKit

class BaseNewsVC: UIViewController {

    func setupStyle() {
        view.backgroundColor = .white
    }
    
    func registerCell(collectionView: UICollectionView) {
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
        collectionView.register(TechnologyCollectionViewCell.self, forCellWithReuseIdentifier: "TechnologyCollectionViewCell")
    }
    
    func showAlert(message: String?) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "") , message: message ?? "No internet connection".loc() , preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "") , style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension String {
    func loc() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
