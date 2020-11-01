//
//  MainViewController.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/28/20.
//

import UIKit

class MainViewController: UICollectionViewController, UISearchBarDelegate {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variables
    
    private let cellID = "searchCellID"
    private let searchController = UISearchController(searchResultsController: nil)
    
    let locationSearchBar = UISearchBar()
    
    private var jobData = [Results]()
    
    var timer: Timer?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        renderSearchBar()
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helper Functions
    
    func style() {
        title = "GitHub Jobs"
        collectionView.backgroundColor = .laurelGreen
    }
    
    private func renderSearchBar() {
        // delegate
        searchController.searchBar.delegate = self
        locationSearchBar.delegate = self
        // variables
        let searchBarTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = .black
        searchBarTextField?.placeholder = "Search for a role"
        
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.view.addSubview(locationSearchBar)
        locationSearchBar.frame = CGRect(x: 10, y: searchController.searchBar.frame.height + 50, width: view.frame.size.width - 30, height: 50)
        locationSearchBar.placeholder = "Location"
        locationSearchBar.layer.cornerRadius = 14
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let position = searchController.searchBar.text, let city = locationSearchBar.text {
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                // API Calling
                Service.shared.fetchData(description: position, location: city) {[weak self] result in
                    switch result {
                    case .success(let results):
                        print(results)
                        self?.jobData = results
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self?.present(ac, animated: true)
                        }
                        print(error)
                    }
                }
            })
        }
    }
    
    
    
}


// MARK: - Extensions

extension MainViewController: UICollectionViewDelegateFlowLayout {
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        cell.layer.cornerRadius = 12
        let jobResult = jobData[indexPath.item]
        cell.jobDataResults = jobResult
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let jobDetailsController = JobDetailsViewController()
        jobDetailsController.jobResults = jobData[indexPath.item]
        navigationController?.pushViewController(jobDetailsController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
    }
}




