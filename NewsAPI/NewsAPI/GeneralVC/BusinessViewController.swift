//
//  GeneralViewController.swift
//  NewsAPI
//
//  Created by Katerina on 04/12/2023.
//

import UIKit
import SnapKit

class GeneralViewController: UIViewController {
    
    // MARK: - GUI Variables,  // добавляем во viewDidLoad() и настраиваем констрейнты
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        //2_передаем екземпляр layout в кол-ю
        let layout = UICollectionViewFlowLayout()
        //3_созд ячейку
        let width = (view.frame.width - 15) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        
        //1_ создаем саму коллекцию
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height - searchBar.frame.height),
                                              collectionViewLayout: layout)
        
        
       
        // 5_ для того что бы setup ячейку в коллекцию - надо реализовать делегат Data Sourse(+ подпишемся)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .lightGray
        
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DataManager.setupTestData()
        
    }
    
    // MARK: - Methods

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .white
        // добавляем во view и настраиваем констрейнты
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        // регистрируем ячейку
        // 4 для того что бы setup ячейку в коллекцию - надо реализовать делегат Data Sourse(+ подпишемся)
        collectionView.register(GeneralCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GeneralCollectionViewCell")
        setupConstraints()
       
    }
    
    
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
         
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // MARK: - Show new ViewControler
    // м-д презентации(на вход: тип ячейки к-ю будет отображать - контент ячейки)
    func showInfoVC(with data: NewsData) {
       // let cellData = DataNews.data
        let infoVC = InfoVC()
       // infoVC.modalPresentationStyle = .popover
        infoVC.data = data
        //present(infoVC, animated: true)
        navigationController?.pushViewController(infoVC, animated: true)
    }
}
// MARK: - UICollectionViewDataSource
extension GeneralViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                            for: indexPath) as? GeneralCollectionViewCell else
        { return UICollectionViewCell() }
        return cell
    }
    // момент нажатия на ячейку()
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print ("first collectionView didSelectItemAt indexPath")
        
        showInfoVC(with: DataManager.dataSource[indexPath.row])

    }
}
    
    // MARK: - UICollectionViewDelegate
extension GeneralViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        navigationController?.pushViewController(InfoVC(), animated: true)
//        }
    }
    

