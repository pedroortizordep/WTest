//
//  PostalCode.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 02/05/22.
//

import Foundation

struct PostalCodeModel {
    var numCodPostal: String = ""
    var extCodPostal: String
    var desigPostal: String
    
    init(desigPostal: String, extCodPostal: String, numCodPostal: String) {
        self.desigPostal = desigPostal
        self.extCodPostal = extCodPostal
        self.numCodPostal = numCodPostal
    }
}
