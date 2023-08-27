//
//  DetailViewController.swift
//  avito
//
//  Created by Danil Komarov on 25.08.2023.
//

import UIKit


class DetailViewController: UIViewController {
    
    var detailModel: DetailModel?
    
    //MARK: - Label
    
    var nameLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var priceLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var locationLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 19, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var createLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var descrLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
         return label
     }()
    var emailLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
         label.numberOfLines = 0
         label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    //MARK: - Loading and Error
    
    var indicator: UIActivityIndicatorView = {
        var indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка", message: "Что-то пошло не так", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }()
    
    //MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addView()
        constraint()
        
        //MARK: Setting up the delay
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.networkDetail()
        }
        
    }
    
    //MARK: - Add view
    
    func addView() {
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(locationLabel)
        view.addSubview(createLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(descrLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(imageView)
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
    }
    
    //MARK: - Constraints
    
    func constraint() {
        indicator.center = view.center
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 25),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -25),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: -25),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailLabel.bottomAnchor.constraint(equalTo: descrLabel.topAnchor, constant: -20),
            
            descrLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            descrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descrLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descrLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
            
            descriptionLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.topAnchor.constraint(equalTo: descrLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: createLabel.topAnchor, constant: -10),
            
            createLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            createLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }
    
    //MARK: - Network
    
    func networkDetail() {
        NetworkService.shared.getItemDetailNetwork(id: Session.shared.idSession) { result in
            switch result {
            case .success(let advertisement):
                self.detailModel = advertisement
                DispatchQueue.main.async {
                    self.nameLabel.text = self.detailModel?.title
                    self.priceLabel.text = self.detailModel?.price
                    self.locationLabel.text = "\(self.detailModel?.location ?? "" ), \(self.detailModel?.address ?? "")"
                    self.createLabel.text = self.detailModel?.createdDate
                    self.descriptionLabel.text = self.detailModel?.description
                    self.emailLabel.text = self.detailModel?.email
                    self.phoneNumberLabel.text = self.detailModel?.phoneNumber
                    self.downloadImage(from: URL(string: self.detailModel?.imageURL ?? "")!)
                    self.indicator.stopAnimating()
                }

            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.present(self.alert, animated: true)
                }
            }
        }
    }
    
    //MARK: - setting imageData
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}
