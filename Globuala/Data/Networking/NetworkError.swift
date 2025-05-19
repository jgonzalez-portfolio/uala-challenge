//
//  NetworkError.swift
//  Globuala
//
//  Created by Joni Gonzalez on 16/05/2025.
//

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case missingUrl = "URL is nil"
    case unwrapperError = "There was an error during the unwrap data"
    case failWithQuery = "No reults"
}

public enum FetchCitiesError: String, Error {
    case repositoryNotFound = "Repository not found"
}
