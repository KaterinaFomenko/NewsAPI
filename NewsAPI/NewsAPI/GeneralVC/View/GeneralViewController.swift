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
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: GeneralViewModelProtocol
    
    // MARK: - Life circle
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //DataManager.setupTestData()
    }
    
    // MARK: - Methods
    // перезагружаем таблицу
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
        }
        
        viewModel.showError = { error in
            // TODO: show alert with error
            print(error)
        }
    }

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
//    // MARK: - Show new ViewControler
//    // м-д презентации(на вход: тип ячейки к-ю будет отображать - контент ячейки)
//    func showInfoVC(with data: ArticleCellViewModel) {
//        let cellData = DataNews.data
//        let infoVC = InfoVC()
//        infoVC.modalPresentationStyle = .popover
//        infoVC.data = data
//        present(infoVC, animated: true)
//        navigationController?.pushViewController(infoVC, animated: true)
//    }
}
// MARK: - UICollectionViewDataSource
extension GeneralViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells   // кол-во ячеек
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCollectionViewCell",
                                                            for: indexPath) as? GeneralCollectionViewCell else
        { return UICollectionViewCell() }
        
        let article = viewModel.getArticle(for: indexPath.row)
        cell.set(article: article)
        print(#function)
        return cell
    }
//    // момент нажатия на ячейку()
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        showInfoVC(with: viewModel.getArticle(for: indexPath.row) )
//    }
}
    
    // MARK: - UICollectionViewDelegate
extension GeneralViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath.row)
        
        navigationController?.pushViewController(InfoVC(viewModel: NewsViewModel(article: article)), animated: true)
        }
}
    
// ------- ViewModel, Model
// Добавляем ViewModel для GeneralViewController
// -- проинициализировать модель (init к-й будет приниматьViewModel )
