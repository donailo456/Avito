//
//  MenuCollectionViewCell.swift
//  avito
//
//  Created by Danil Komarov on 24.08.2023.
//

import UIKit

class MenuCollectionViewCellModel {
    let idItem: String
    let title: String
    let price: String
    let location: String
    let imageUrl: URL?
    var imageData: Data?
    let data: String
    
    init(idItem: String, title: String, price: String, location: String, imageUrl: URL?, imageData: Data? = nil, data: String) {
        self.idItem = idItem
        self.title = title
        self.price = price
        self.location = location
        self.imageUrl = imageUrl
        self.imageData = imageData
        self.data = data
    }
}

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 14, weight: .medium)
         return label
     }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .bold)
         return label
     }()
    var locationLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13, weight: .regular)
         return label
     }()
    var dataLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
         return label
     }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
         imageView.backgroundColor = .secondarySystemBackground
         imageView.clipsToBounds = true
         imageView.contentMode = .scaleAspectFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
         return imageView
    }()
    var indicator: UIActivityIndicatorView = {
        var indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.frame = CGRect(x: 70, y: 60, width: 40, height: 40)
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        constraint()
        
    }
    
    func constraint() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 145),
            imageView.heightAnchor.constraint(equalToConstant: 145),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            nameLabel.widthAnchor.constraint(equalToConstant: 145),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(equalTo: dataLabel.topAnchor),
            
            dataLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setup() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(dataLabel)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(indicator)
        
    }
    
    func configure(with viewModel: MenuCollectionViewCellModel) {
        nameLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        locationLabel.text = viewModel.location
        dataLabel.text = viewModel.data
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageUrl {
            URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                    self?.indicator.stopAnimating()
                }
            }.resume()
        }
    }
    
}
