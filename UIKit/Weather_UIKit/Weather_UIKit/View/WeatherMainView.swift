//
//  WeatherMainView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit
import Combine

class WeatherMainView: UIViewController, AddCityDelegate {
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private let weatherViewModel = WeatherMainViewModel()
    private lazy var cityModels: [CityModel] = []
    var cancellable = Set<AnyCancellable>()
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 500, target: self, selector: #selector(reloadData), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        setTable()
        setSubscriber()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("timer finish")
        timer?.invalidate()
        timer = nil
    }
    
    func configureNavigation() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addWeather))
    }
    
    func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherMainViewCell.self, forCellReuseIdentifier: "WeatherMainViewCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // 여기다가 만드는게 맞나?
    func setSubscriber() {
        
        self.weatherViewModel.cities.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("error > \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] cities in
            self?.cityModels = cities
            self?.tableView.reloadData()
//            DispatchQueue.main.async {
//            }
        }.store(in: &cancellable)
    }
    
    @objc func addWeather() {
        let addView = WeatherAddView()
        addView.weatherDelegate = self
        navigationController?.pushViewController(addView, animated: true)
    }
    
    @objc func reloadData() {
        weatherViewModel.loadCities()
    }
    
    // Delegate
    func addNewCity(newCity: CityModel) {
        weatherViewModel.addNewCity(newCity: newCity)
    }
}

extension WeatherMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherMainViewCell", for: indexPath) as? WeatherMainViewCell else {
            return UITableViewCell()
        }
        
        let targetCity = self.cityModels[indexPath.row]
        cell.configureUI(city: targetCity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = WeatherDetailView()
        detailView.receivedCity = cityModels[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherViewModel.removeCity(targetCity: self.cityModels[indexPath.row])
            
        }
    }
}
