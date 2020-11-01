//
//  SearchResultCell.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/28/20.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    var jobDataResults: Results! {
        didSet {
            companyLabel.text = jobDataResults.company
            jobTitleLabel.text = jobDataResults.title
            jobTypeLabel.text = jobDataResults.type
            locationLabel.text = jobDataResults.location
            guard let url = URL(string: jobDataResults.companyLogo ?? "") else { return }
            logoImageView.sd_setImage(with: url)
            
        }
    }
    
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Google"
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Software Engineer"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let jobTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full-Time"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        cellStyle()
        
    }
    
    // MARK: - Helper Functions
    
    func cellStyle() {
        backgroundColor = .deepSpaceSparkle
        // logoImageView style
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 80, height: 100))
        
        // StackView style
        let stackView = UIStackView(arrangedSubviews: [companyLabel, jobTitleLabel, locationLabel, jobTypeLabel])
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: logoImageView.leadingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
    }
    

    // MARK: - Selectors
    
    

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
