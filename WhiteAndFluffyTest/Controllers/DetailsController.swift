//
//  DetailsController.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import UIKit
import SDWebImage

class DetailsController: UIViewController {
    
    var photo: Photo!
    
    // MARK: - UI Elements
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var creationDateLabel: UILabel = {
        let label = UILabel()
        var creationDateStringSubSequence = photo.created_at.prefix(10)
        label.text = String(creationDateStringSubSequence)
        return label
    }()
    
    private lazy var locationLabel = UILabel(text: photo.user.location ?? "some place")
    private lazy var downloadsLabel = UILabel(text: "\(photo.downloads ?? 0)")
    private lazy var userNameLabel = UILabel(text: photo.user.name)
    
    private lazy var creationDateImageView = UIImageView(image: UIImage(systemName: "calendar"))
    private lazy var locationImageView = UIImageView(image: UIImage(systemName: "map"))
    private lazy var downloadsImageView = UIImageView(image: UIImage(systemName: "square.and.arrow.down"))
    private lazy var userNameImageVIew = UIImageView(image: UIImage(systemName: "person.circle"))
    
    private lazy var creationStackView = UIStackView(arrangedSubviews: [creationDateImageView, creationDateLabel])
    private lazy var locationStackView = UIStackView(arrangedSubviews: [locationImageView, locationLabel])
    private lazy var downloadsStackView = UIStackView(arrangedSubviews: [downloadsImageView, downloadsLabel])
    private lazy var userNameStackView = UIStackView(arrangedSubviews: [userNameImageVIew, userNameLabel])
    
    // MARK: - ViewDidLoad and private setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Details"
        
        setupAddBarButton()
        setupPhotoImageView()
        setupMetaData()
    }
    
    // MARK: - Setup UI functions
    
    private func setupAddBarButton() {
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    private func setupPhotoImageView() {
        view.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoImageView.sd_setImage(with: URL(string: photo.urls.regular), completed: nil)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
    
    private func setupMetaData() {
        view.addSubview(creationStackView)
        view.addSubview(locationStackView)
        view.addSubview(downloadsStackView)
        view.addSubview(userNameStackView)
        
        creationStackView.translatesAutoresizingMaskIntoConstraints = false
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        downloadsStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        creationStackView.spacing = 10
        locationStackView.spacing = 10
        downloadsStackView.spacing = 10
        userNameStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            creationStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            creationStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            locationStackView.topAnchor.constraint(equalTo: creationStackView.bottomAnchor, constant: 10),
            locationStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            downloadsStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 10),
            downloadsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),

            userNameStackView.topAnchor.constraint(equalTo: downloadsStackView.bottomAnchor, constant: 10),
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }
    
    // MARK: - Navigation BarButton action + Alert
    
    @objc
    private func addBarButtonTapped() {
        
        let alertController = UIAlertController(title: "Do you like this photo?", message: "Photo will be added to favorites", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            
            let mainTabBarController = self.tabBarController as! MainTabBarController
            let navigationController = mainTabBarController.viewControllers?[1] as! UINavigationController
            let tableController = navigationController.topViewController as! TableController
        
            tableController.favoritesPhotos.append(self.photo)
            tableController.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
}
