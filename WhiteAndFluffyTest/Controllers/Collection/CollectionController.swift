//
//  CollectionController.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import UIKit

class CollectionController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: CollectionController.createCompositionalLayout())
    }
    
    static func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private variables
    
    private var photos: [Photo] = []
    
    // MARK: - UI Elements
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - ViewDidLoad and private setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "Photos"
        
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseId)
        
        setupSearchBar()
        setupSpinner()
        
        NetworkManager.shared.fetchRandomPhotos { [weak self] fetchedPhotos in
            self?.photos = fetchedPhotos
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Setup UI Elements
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
    
    // MARK: - Collection dataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseId, for: indexPath) as! CollectionCell
        cell.photo = photos[indexPath.item]
        return cell
    }
    
    // MARK: - Collection delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = DetailsController()
        detailsController.photo = photos[indexPath.item]
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

    // MARK: - SearchBar delegate

extension CollectionController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        spinner.startAnimating()
        NetworkManager.shared.searchPhotos(query: searchBar.text!) { [weak self] fetchedPhotos in
            self?.spinner.stopAnimating()
            self?.photos = fetchedPhotos?.results ?? []
            self?.collectionView.reloadData()
        }
    }
}



// MARK: - Canvas
import SwiftUI

struct CollectionControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CollectionControllerProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: CollectionControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CollectionControllerProvider.ContainerView>) {}
    }
}
