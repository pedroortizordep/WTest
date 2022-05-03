//
//  PostalCodesViewController.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 30/04/22.
//

import Foundation
import UIKit

class PostalCodesViewController: UIViewController, ViewConfiguration {
    
    private var customView: PostalCodesView = PostalCodesView()
    
    private let searchController = UISearchController()
    
    private var viewModel: PostalCodesViewModel = PostalCodesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.getPostalCodes()
    }
    
    private func setup() {
        setupNavigation()
        setupSearchBar()
        setupKeyboard()
        
        initialize()
        customView.setupView(delegate: self, dataSource: self)
        bindPostalCodes()
    }
    
    private func setupNavigation() {
        searchController.searchResultsUpdater = self
        navigationItem.title = "Postal Codes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupKeyboard() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.customView.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.customView.frame.origin.y = 0
    }
    
    func bindPostalCodes() {
        viewModel.bindPostalCodesToController = {
            self.customView.changeLoadingState()
            self.customView.tableViewPostalCodes.reloadData()
        }
    }
    
    func addViews() {
        view.addSubview(customView)
    }
    
    func addConstraints() {
        customView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension PostalCodesViewController: UITableViewDelegate {}

extension PostalCodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postalCodes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postalCodeCell", for: indexPath) as? PostalCodeCell {
            let postalCode = self.viewModel.getPostalCode(index: indexPath.row)
            cell.configure(postalCode: postalCode)
            return cell
        }
        
        return UITableViewCell()
    }
}

extension PostalCodesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if !text.isEmpty {
            viewModel.fetchPostalCodes(searchText: text)
        } else {
            viewModel.getPostalCodes()
        }
    }
}

