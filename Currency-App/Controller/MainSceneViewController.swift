//
//  ViewController.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import UIKit

let cellIdentifier = "cellID"

class MainSceneViewController: UITableViewController {

    //MARK: - Data
    private let viewModel = CurrenciesViewModel()
    
    //MARK: - Properies
    
//    private let tableView = UITableView()
    private var currentFilter: CurrencyListOption = .A {
        didSet {
            viewModel.changeTable(withOption: currentFilter)
            refreshControl?.beginRefreshing()
            callFetchFromFilter()
        }
    }
    
//    let refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData(withParameter: "A")
    }
    
    //MARK: - API
    
    func fetchData(withParameter parameter: String){
        viewModel.fetchCurrencies(withParameter: parameter) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) { //TODO: - FOR DEBUG PURPOSES -> CHANGE TO ASYNC
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Selectors
    
    @objc func refreshUI(){
        callFetchFromFilter()
    }
    
    //MARK: - Helpers

    func configureUI(){
        tableView.refreshControl = UIRefreshControl()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Waluty"
        
        view.backgroundColor = .white
        tableView.backgroundColor = .white
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//        ])
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        
        let header = CurrencyListHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        header.delegate = self
        tableView.tableHeaderView = header
        
        tableView.refreshControl = refreshControl
        refreshControl?.tintColor = .black
        refreshControl?.addTarget(self, action: #selector(refreshUI), for: .valueChanged)
    }
    
    func callFetchFromFilter(){
        switch currentFilter {
        case .A:
            fetchData(withParameter: "A")
        case .B:
            fetchData(withParameter: "B")
        case .C:
            fetchData(withParameter: "C")
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainSceneViewController/*: UITableViewDelegate, UITableViewDataSource*/{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCurrencies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CurrencyCell
        cell.selectionStyle = .none
        cell.viewModel = CurrencyItemViewModel(withCurrency: viewModel.currencies[indexPath.row], withDate: viewModel.date)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let code = viewModel.currencies[indexPath.row].code ?? ""
        let controller = CurrencyDetailsController(withTable: viewModel.currentTable, withCode: code)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: - CurrencyListHeaderViewDelegate

extension MainSceneViewController: CurrencyListHeaderViewDelegate {
    func changeFilter(withOption option: CurrencyListOption) {
        switch option {
        case .A:
            self.currentFilter = .A
        case .B:
            self.currentFilter = .B
        case .C:
            self.currentFilter = .C
        }
    }
}

