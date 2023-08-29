//
//  DetailViewController.swift
//  avito
//
//  Created by Danil Komarov on 25.08.2023.
//

import UIKit


class DetailViewController: UIViewController {
    
    var detailModel: DetailModel?
    var number: String?
    
    //MARK: - Detail View label
    
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
    var descriptionTextView: UITextView = {
        let label = UITextView()
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
    var contactLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Контактная информация"
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Detail View Button
    
    var numberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Detail View Image
    
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
        
        //MARK: Add target
        
        addTargetButton()
        
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
        view.addSubview(descriptionTextView)
        view.addSubview(descrLabel)
        view.addSubview(contactLabel)
        view.addSubview(emailLabel)
        view.addSubview(numberButton)
        view.addSubview(phoneNumberLabel)
        view.addSubview(imageView)
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
    }
    
    //MARK: - Setting Button
    
    func addTargetButton() {
        numberButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
    }
    
    @objc func callNumber() {
        let phoneNumber = "tel://\(number ?? "0")"
        guard let url = URL(string: phoneNumber) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Constraints
    
    func constraint() {
        indicator.center = view.center
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 25),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -10),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(equalTo: numberButton.topAnchor, constant: -25),
            
            numberButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            numberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            numberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberButton.bottomAnchor.constraint(equalTo: contactLabel.topAnchor, constant: -15),
            
            contactLabel.topAnchor.constraint(equalTo: numberButton.bottomAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contactLabel.bottomAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: -3),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -3),
            
            emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailLabel.bottomAnchor.constraint(equalTo: descrLabel.topAnchor, constant: -20),
            
            descrLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            descrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descrLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descrLabel.bottomAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: -5),
            
            descriptionTextView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextView.topAnchor.constraint(equalTo: descrLabel.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: createLabel.topAnchor, constant: -10),
            
            createLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
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
                    self.descriptionTextView.text = self.detailModel?.description
                    self.emailLabel.text = self.detailModel?.email
                    self.phoneNumberLabel.text = self.detailModel?.phoneNumber
                    self.number = self.detailModel?.phoneNumber
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
