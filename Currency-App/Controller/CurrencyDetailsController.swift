//
//  CurrencyViewController.swift
//  Currency-App
//
//  Created by Karol Korzeń on 15/01/2022.
//

import UIKit

let cell2Identifier = "cell2ID"

class CurrencyDetailsController: UITableViewController {

    //MARK: - Data
    private let viewModel = CurrencyDetailsViewModel()
    private let code: String
    private let table: String
    
    private var startDate = Date.init().weekBefore
    private var endDate = Date.init()
    
    //MARK: - Properies
    
    
    
    //MARK: - Lifecycle
    
    init(withTable table: String, withCode code: String){
        self.code = code
        self.table = table
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Szczegóły"
        initFetchData()
    }
    
    //MARK: - API
    
    func initFetchData() {
        viewModel.fetchCurrencyDetails(withTable: self.table, withCurrencyCode: self.code) {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    func fetchData(withStartDate startDate: Date, withStopDate endDate:Date){
        viewModel.fetchCurrencyDetails(withTable: self.table, withCurrencyCode: self.code, withStartDate: startDate, withEndDate: endDate) {
            self.refreshControl?.beginRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //TODO: - FOR DEBUG PURPOSES -> CHANGE TO ASYNC
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Selectors
    
    @objc func refreshUI(){
        fetchData(withStartDate: self.startDate, withStopDate: self.endDate)
    }
    
    //MARK: - Helpers

    func configureUI(){
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyDetailsCell.self, forCellReuseIdentifier: cell2Identifier)
        tableView.separatorStyle = .none
        
        let header = CurrencyDetailsHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150), codeName: viewModel.codeString, currencyName: viewModel.currencyString)
        header.delegate = self
        tableView.tableHeaderView = header
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .black
        tableView.refreshControl?.addTarget(self, action: #selector(refreshUI), for: .valueChanged)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension CurrencyDetailsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRates
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell2Identifier) as! CurrencyDetailsCell
        cell.selectionStyle = .none
        cell.viewModel = CurrencyDetailsCellViewModel(withRate: viewModel.rates[indexPath.row], withCode: viewModel.codeString, withNo: viewModel.rates[indexPath.row].no ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: - CurrencyListHeaderViewDelegate

extension CurrencyDetailsController: CurrencyDetailsHeaderViewDelegate {
    func changedDate(withStartDate startDate: Date, withEndDate endDate: Date) {
        self.endDate = endDate
        self.startDate = startDate
        fetchData(withStartDate: startDate, withStopDate: endDate)
    }
}

