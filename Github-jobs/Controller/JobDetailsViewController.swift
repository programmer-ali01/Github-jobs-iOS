//
//  JobDetailsViewController.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/29/20.
//

import UIKit
import SafariServices

class JobDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var jobResults: Results! {
        didSet {
            companyLabel.text = jobResults.company
            jobTitleLabel.text = jobResults.title
            jobTypeLabel.text = jobResults.type
            locationLabel.text = jobResults.location
            guard let url = URL(string: jobResults.companyLogo ?? "") else {return}
            logoImageView.sd_setImage(with: url)
            companyUrl = jobResults.companyUrl ?? ""
            applyUrl = jobResults.url ?? ""
            htmlText = jobResults.description ?? ""
            let descriptionHTML = convertHTML(text: htmlText, attributedText: &descriptionTextView.attributedText)
            descriptionTextView.attributedText = descriptionHTML
        }
    }
    
    
    
    var pinchGesture = UIPinchGestureRecognizer()
    
    let logoImageView = AspectFitImageView(image: UIImage(named: ""), cornerRadius: 12)
    
    var htmlText = """
        
 """
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Awesome company"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Software Engineer"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    let jobTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full-Time"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    let urlButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Visit Copmpany Website", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .deepSpaceSparkle
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleCompanyURL), for: .touchUpOutside)
        return button
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 25)
        textView.textAlignment = .left
        textView.backgroundColor = .laurelGreen
        textView.textColor = UIColor.white
        textView.layer.cornerRadius = 12
        textView.isEditable = false
        return textView
    }()
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .deepSpaceSparkle
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleApplyButton), for: .touchUpInside)
        return button
    }()
    
    var companyUrl = "github.com"
    var applyUrl = ""
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchText(sender: )))
        descriptionTextView.addGestureRecognizer(pinchGesture)
        
        // Calling functions
        jobDescriptionStyle()
        
    }
    
    
    // MARK: - Selectors
    
    @objc func handleCompanyURL() {
        if companyUrl == "" {
            let ac = UIAlertController(title: "Link is not available", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        guard let url = URL(string: companyUrl) else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
    }
    
    
    @objc func handleApplyButton() {
        if applyUrl == "" {
            let ac = UIAlertController(title: "Link is not available to apply for this job", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        guard let url = URL(string: applyUrl) else { return }
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true)
    }
    
    @objc func pinchText(sender: UIPinchGestureRecognizer) {
        var pointSize = descriptionTextView.font?.pointSize
        pointSize = ((sender.velocity > 0) ? 1: -1) * 1 + pointSize!
        descriptionTextView.font = UIFont(name: "arial", size: (pointSize!))
    }
    
    
    
    // MARK: - Helper Functions
    
    func jobDescriptionStyle() {
        view.backgroundColor = .laurelGreen
        // logoImageView
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: 80, height: 100))
        
        // StackView
        let stackView = UIStackView(arrangedSubviews: [companyLabel, jobTitleLabel, jobTypeLabel, locationLabel, urlButton])
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: logoImageView.leadingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // descriptionTextView
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: stackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        descriptionTextView.attributedText = convertHTML(text: htmlText, attributedText: &descriptionTextView.attributedText)
        
        // applyButton
        view.addSubview(applyButton)
        applyButton.anchor(top: descriptionTextView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 70, bottom: 30, right: 70))
        
     
        
    }
    
    
    func convertHTML(text: String, attributedText: inout NSAttributedString) -> NSAttributedString {
        let data = Data(text.utf8)
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,
                                                                           .characterEncoding: String.Encoding.utf8.rawValue]
        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attributedString
            return attributedString
        }
        return attributedText
    }
    
}
