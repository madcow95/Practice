//
//  WeatherMainView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit
import Combine

class WeatherMainView: UIViewController, AddCityDelegate {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(WeatherMainViewCell.self, forCellReuseIdentifier: "WeatherMainViewCell")
        
        return table
    }()
    
    private let weatherViewModel = WeatherMainViewModel()
    private let cityList = WeatherMainViewModel().getCityList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        setTable()
    }
    
    func configureNavigation() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addWeather))
    }
    
    func setTable() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addWeather() {
        let addView = WeatherAddView()
        navigationController?.pushViewController(addView, animated: true)
    }
    
    // Delegate
    func addNewCity(newCity: WeatherModel) {
        weatherViewModel.addNewCity(newCity: newCity)
        self.tableView.reloadData()
    }
}

extension WeatherMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherMainViewCell", for: indexPath) as? WeatherMainViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
}
