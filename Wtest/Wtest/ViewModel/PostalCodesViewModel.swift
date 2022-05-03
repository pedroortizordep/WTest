//
//  PostalCodesViewModel.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 30/04/22.
//

import Foundation

class PostalCodesViewModel {
    
    private var postalCodesService: PostalCodesService
    
    private(set) var postalCodes: [PostalCode] {
        didSet {
            self.bindPostalCodesToController()
        }
    }
    
    var bindPostalCodesToController: (() -> ()) = {}
    
    init() {
        postalCodesService = PostalCodesService()
        postalCodes = []
    }
    
    func getPostalCodes() {
        let postalCodesData = DataManager.shared.getPostalCodesData()
        
        if postalCodesData.isEmpty {
            postalCodesService.getPostalCodes { result in
                switch result {
                case .success(let postalCodes):
                    self.postalCodes = postalCodes
                case .failure(let error):
                    debugPrint(error)
                }
            }
        } else {
            postalCodes = postalCodesData
        }
    }
    
    func getPostalCode(index: Int) -> PostalCode {
        return postalCodes[index]
    }
    
    func fetchPostalCodes(searchText: String) {
        let editedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        postalCodes = DataManager.shared.fetchPostalCodes(searchText: editedSearchText)
    }
}

