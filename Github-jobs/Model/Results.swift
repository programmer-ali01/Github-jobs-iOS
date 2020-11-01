//
//  Results.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/29/20.
//

import Foundation

struct Results: Codable {
    var type: String?
    var url: String?
    var createdAt: String?
    var company: String?
    var companyUrl: String?
    var location: String?
    var title: String
    var description: String?
    var howToApply: String?
    var companyLogo: String?
}
