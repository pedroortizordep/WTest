//
//  PostalCodesView.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 30/04/22.
//

import Foundation
import UIKit

class PostalCodesView: UIView, ViewConfiguration {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    lazy var tableViewPostalCodes: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(PostalCodeCell.self, forCellReuseIdentifier: "postalCodeCell")
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableViewPostalCodes.delegate = delegate
        tableViewPostalCodes.dataSource = dataSource
        initialize()
        changeLoadingState()
    }
    
    func addViews() {
        addSubview(tableViewPostalCodes)
        addSubview(activityIndicator)
    }
    
    func addConstraints() {
        tableViewPostalCodes.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableViewPostalCodes.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableViewPostalCodes.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableViewPostalCodes.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        activityIndicator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func changeLoadingState() {
        if activityIndicator.isAnimating {
            activityIndicator.removeFromSuperview()
        } else {
            activityIndicator.startAnimating()
        }
    }
}

