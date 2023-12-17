//
//  BusinessViewController.swift
//  NewsAPI
//
//  Created by Katerina on 05/12/2023.
//

import UIKit
import SnapKit

class BusinessViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       
//        let width = view.frame.width
//        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 20,
                                           bottom: 20,
                                           right: 20)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height),
                                              collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
     //   DataManager.setupTestData()
        
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
    
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    }
    
    // MARK: - Methods

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
    
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
           
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // MARK: - Show new ViewControler
   
//    func showInfoVC(with data: NewsData) {
//        let infoVC = InfoVC()
//        //infoVC.data = data
//        navigationController?.pushViewController(infoVC, animated: true)
//    }
}
// MARK: - UICollectionViewDataSource
extension BusinessViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 1 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell", for: indexPath) as? GeneralCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell
        }
       
        return cell ?? UICollectionViewCell()
    }
   
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showInfoVC(with: DataManager.dataSource[indexPath.row])
//    }
}
    
    // MARK: - UICollectionViewDelegate
extension BusinessViewController: UICollectionViewDelegate {

    }
// MARK: - UICollectionViewDelegateFlowLayout
extension BusinessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let firstSectionItemSize = CGSize(width: width, height: width)
        let secondSectionItemSize = CGSize(width: width, height: 100)
        
        return indexPath.section == 0 ? firstSectionItemSize : secondSectionItemSize
        
        
    }
}
// нужно проинициализировать ячейку в BusinessVC для этого нам нужно ее зарегистрировать во ViewDidLoad - "collectionView.register"
// укажем кол-во секций в коллекции (м-д из UICollectionViewDataSource - "numberOfSections"), контроль numberOfItemsInSection, cellForItemAt indexPath(выбранная ячейка)
// sectionInset -  расстояние между секциями
// itemSize для этого есть делегат(в отд extension) - UICollectionViewDelegateFlowLayout
// ------- ViewModel, Model
// Добавляем ViewModel для GeneralViewController
