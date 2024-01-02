//
//  InfoVC.swift
//  NewsAPI
//
//  Created by Katerina on 06/12/2023.
//

import UIKit
import SnapKit

final class InfoVC: UIViewController {
    var data: ArticleCellViewModel?
    
    // MARK: - GUI Variables,  // добавляем во viewDidLoad() и настраиваем констрейнты
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
       
        return view
    }()
    
    private lazy var contentView = UIView()
    
//    private lazy var backButton: UIButton = {
//        let button = UIButton()
//
//        let image = UIImage(systemName: "chevron.backward") ?? UIImage()
//        button.setImage(image, for: .normal)
//
//        return button
//    }()
    
    private lazy var infoImageView: UIImageView = {
        let imageInfo = UIImageView()
        
        return imageInfo
    }()
    
    private lazy var infoTitle: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var descriptionNews: UILabel = {
        var description = UILabel()
        
        description.font = .systemFont(ofSize: 14)
        description.textColor = .darkGray
        description.numberOfLines = 0
        
        return description
    }()
    
    private lazy var datePublic: UILabel = {
        var date = UILabel()
        
        date.font = .systemFont(ofSize: 12)
        date.textColor = .darkGray
      
        return date
    }()
    
    // MARK: - Properties
    let edgeInset = 10
    private let viewModel: NewsViewModelProtocol
    
    // MARK: - Life circle
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false  // ?????
        
        setupUI()
      //  tapBackButton(button: backButton)
        loadData()
    }
    
    func loadData() {
        self.title = viewModel.title
        
        infoTitle.text = viewModel.title
        descriptionNews.text = viewModel.description + viewModel.description + viewModel.description + viewModel.description + viewModel.description + viewModel.description

        datePublic.text = viewModel.date
        
        if let imageData = viewModel.imageData,
           let image = UIImage(data: imageData) {
            infoImageView.image = image
            infoImageView.contentMode = .scaleAspectFill
            infoImageView.clipsToBounds = true
        } else {
            infoImageView.image = UIImage(named: "Image")
        }
    }
    
    // MARK: - Methods
    
//    // MARK: - Private methods
//    private func tapBackButton(button: UIButton) {
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        print("back button")
//    }
//    @objc
//    func backButtonTapped(){
//        if let navigationController = self.navigationController {
//            navigationController.popViewController(animated: true)
//        }
//    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
      //  contentView.addSubview(backButton)
        contentView.addSubview(infoImageView)
        contentView.addSubview(infoTitle)
        contentView.addSubview(descriptionNews)
        contentView.addSubview(datePublic)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        
//        backButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(edgeInset)
//            make.top.equalToSuperview().inset(edgeInset)
//        }
//
        infoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
            make.height.equalTo(view.snp.width)
        }
        
        datePublic.snp.makeConstraints { make in
            make.top.equalTo(infoImageView.snp.bottom).offset(edgeInset)
            make.trailing.leading.equalToSuperview().inset(edgeInset)
        }
        
        infoTitle.snp.makeConstraints { make in
            make.top.equalTo(datePublic.snp.bottom).offset(edgeInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
        }
    
        descriptionNews.snp.makeConstraints { make in
            make.top.equalTo(infoTitle.snp.bottom).offset(edgeInset)
            make.trailing.leading.equalToSuperview().inset(edgeInset)
            make.bottom.equalToSuperview().inset(edgeInset)
        }
    }
}

