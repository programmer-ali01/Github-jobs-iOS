//
//  ErrorMessage.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/29/20.
//

import Foundation

enum ErrorMessages: String, Error {
    case invalidData = "Something went wrong, unable to fetch data."
    case invalidResponse = "Server Error."
}
