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
    var cancellable = Set<AnyCancellable>()
    var weatherDatas: [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        setTable()
        weatherViewModel.weatherDelegate = self
        
        self.weatherViewModel.cities.sink { completion in
            switch completion {
            case .finished:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                print("error > \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] weathers in
            self?.weatherDatas = weathers
        }.store(in: &cancellable)
        weatherViewModel.loadCities()
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
        addView.weatherDelegate = self
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
        return self.weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherMainViewCell", for: indexPath) as? WeatherMainViewCell else {
            return UITableViewCell()
        }
        
        let targetWeather = self.weatherDatas[indexPath.row]
        cell.configureUI(weather: targetWeather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
}
