//
//  ViewController.swift
//  avito
//
//  Created by Danil Komarov on 24.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.backgroundColor = .systemGray
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    private var viewModels = [MenuCollectionViewCellModel]()
    private var advertisement = [Advertisement]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNetwork()
    }
    
    func setupViews() {
        view.addSubview(myCollectionView)
    }
    
    func setupNetwork() {
        NetworkService.shared.getItemNetwork { [weak self] result in
            switch result {
            case .success(let advertisement):
                self?.advertisement = advertisement
                self?.viewModels = advertisement.compactMap({
                    MenuCollectionViewCellModel(idItem: $0.id, title: $0.title, price: $0.price, location: $0.location, imageUrl: URL(string: $0.imageURL), data: $0.createdDate)
                })
                
                DispatchQueue.main.async {
                    self?.myCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell{

            itemCell.configure(with: viewModels[indexPath.row])
            
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        Session.shared.idSession = viewModels[indexPath.row].idItem
//        print(viewModels[indexPath.row].idItem)
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3*16) / 2
        return CGSize(width: width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

