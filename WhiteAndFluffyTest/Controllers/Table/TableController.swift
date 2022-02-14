//
//  TableController.swift
//  WhiteAndFluffyTest
//
//  Created by Михаил Кулагин on 01.02.2022.
//

import UIKit
import SDWebImage

class TableController: UITableViewController {
    
    var favoritesPhotos: [Photo] = []
    
    // MARK: - UI Elements
    
    private lazy var welcomeLabel = UILabel(text: "You haven't added photos yet 😑")

    // MARK: - ViewDidLoad and private setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites"
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        setupWelcomeLabel()
    }
    
    // MARK: - Setup UI functions
    
    private func setupWelcomeLabel() {
        tableView.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100).isActive = true
    }
    
    // MARK: - Table dataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        welcomeLabel.isHidden = favoritesPhotos.count != 0
        return favoritesPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.imageView?.sd_setImage(with: URL(string: favoritesPhotos[indexPath.row].urls.small), completed: nil)
        cell.textLabel?.text = favoritesPhotos[indexPath.row].user.name
        return cell
    }
    
    // MARK: - Table delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController = DetailsController()
        let onePhoto = favoritesPhotos[indexPath.item]
        detailsController.photo = onePhoto
        navigationController?.pushViewController(detailsController, animated: true)
    }

}
