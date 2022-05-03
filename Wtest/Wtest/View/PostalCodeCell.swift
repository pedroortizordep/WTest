//
//  PostalCodeCell.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 02/05/22.
//

import Foundation
import UIKit

class PostalCodeCell: UITableViewCell, ViewConfiguration {
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelCode: UILabel = {
        let label = UILabel()
        label.applyStyle(color: .black, fontName: .appleSDBold, size: 24)
        return label
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.applyStyle(color: .lightGray, fontName: .appleSDRegular, size: 18)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(postalCode: PostalCode) {
        initialize()
        
        if let numCodPostal = postalCode.numCodPostal,
           let extCodPostal = postalCode.extCodPostal,
           let desigPostal = postalCode.desigPostal {
            labelCode.text = "\(numCodPostal) - \(extCodPostal)"
            labelName.text = desigPostal
        }
    }
    
    func addViews() {
        addSubview(viewContainer)
        viewContainer.addSubview(labelCode)
        viewContainer.addSubview(labelName)
    }
    
    func addConstraints() {
        viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        labelCode.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 16).isActive = true
        labelCode.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 16).isActive = true
        labelCode.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        
        labelName.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 16).isActive = true
        labelName.topAnchor.constraint(equalTo: labelCode.bottomAnchor).isActive = true
        labelName.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        
    }
}

