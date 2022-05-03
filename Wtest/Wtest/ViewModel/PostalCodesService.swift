//
//  PostalCodesService.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 30/04/22.
//

import Foundation
import Alamofire

class PostalCodesService {
    
    private let postalCodesURL: String = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv"
    
    func getPostalCodes(completion: @escaping (Result<[PostalCode], Error>) -> ()) {
        AF.request(postalCodesURL)
            .validate()
            .responseData(completionHandler: { (response) in
                
                if let error = response.error {
                    completion(.failure(error))
                }
                
                guard let data = response.data else { return }
                var dataStr = ""
                
                do {
                    dataStr = String(data: data, encoding: .utf8) ?? ""
                }
                
                var rows = dataStr.components(separatedBy: "\n")
                
                var postalCodes: [PostalCode] = []
                
                // Removing headers from csv file
                rows.removeFirst()
                
                // Getting values from columns and creating a PostalCode model
                for row in rows {
                    if !row.isEmpty {
                        var columns = row.components(separatedBy: ",")
                        
                        // Getting necessary attributes
                        let postalCodeModel = PostalCodeModel(desigPostal: columns.removeLast(), extCodPostal: columns.removeLast(), numCodPostal: columns.removeLast())
                        
                        let postalCode = DataManager.shared.createPostalCodeCoreDataModel(postalCodeModel: postalCodeModel)
                        postalCodes.append(postalCode)
                    }
                }
                
                DataManager.shared.save()
                completion(.success(postalCodes))
            })
    }
}
