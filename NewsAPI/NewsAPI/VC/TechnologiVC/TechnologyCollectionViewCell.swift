//
//  TechCollectionViewCell.swift
//  NewsAPI
//
//  Created by Katerina on 26/12/2023.
//

import Foundation
import UIKit
import SnapKit

final class TechnologyCollectionViewCell: UICollectionViewCell {
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = 12.0
        imageView.layer.masksToBounds = false
        
        return imageView
    }()
    
    private lazy var grayRec: UIView = {
        let titleFrame = UIView()
        titleFrame.backgroundColor = .systemGray6
        
        titleFrame.layer.cornerRadius = 8.0
        titleFrame.layer.masksToBounds = false
        
        titleFrame.layer.shadowColor = UIColor.lightGray.cgColor
        titleFrame.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        titleFrame.layer.shadowRadius = 1
        titleFrame.layer.shadowOpacity = 0.8
        
        return titleFrame
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title Technologi"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "Description foe the news will be here. Description foe the news will be here. Description foe the news will be here. Description foe the news will be here. Description foe the news will be here."
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var datePublic: UILabel = {
        let label = UILabel()
        label.text = "26.12.23"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    // Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        grayRec.layer.shadowPath = UIBezierPath(roundedRect: grayRec.bounds, cornerRadius: 12).cgPath
    }
    
    // MARK: Methods
    func set(article: ArticleCellViewModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        datePublic.text = article.date
        
        if let data = article.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        } else {
            imageView.image = UIImage(named: "Image")
        }
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(grayRec)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(datePublic)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            let widthSize = self.frame.width / 3
            
            make.width.equalTo(widthSize)
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        grayRec.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.top.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.size.equalTo(grayRec).inset(5)
            make.leading.equalTo(grayRec.snp.leading)
            make.trailing.equalToSuperview().inset(5)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRec.snp.bottom).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(5)
        }
        
        datePublic.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
