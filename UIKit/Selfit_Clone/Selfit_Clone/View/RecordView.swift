//
//  HomeView.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import UIKit
import Combine

class RecordView: UIViewController {
    
    private let recordViewModel: RecordViewModel = RecordViewModel()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setNavigationTitle()
        setNavigationButtons()
        setScrollView()
        // MARK: TODO. 달력 집어넣기(Custom으로 할지 기본 Calendar로 할지..)
        loadRecordList()
        setCalendar()
//        setTable()
    }
    
    func setNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = Date().currentFullDateString()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        titleView.addSubview(titleLabel)

        self.navigationItem.titleView = titleView
    }
    
    // MARK: TODO. 버튼들 색깔 바꾸기
    func setNavigationButtons() {
        let lockButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .plain, target: self, action: nil)
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toRecordCreateView))
        
        navigationItem.rightBarButtonItems = [addButton, listButton, lockButton]
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setRecords(workout: Workout) {
        let date: String = workout.date
        let category: String = workout.category
        let subCategory: String = workout.subCategory
        let sets: Int = workout.records.sets
        let reps: [Int] = workout.records.reps
        let weights: [Int] = workout.records.weights
        
        
    }
    
    var anyCancellable: AnyCancellable?
    func loadRecordList() {
        anyCancellable?.cancel()
        anyCancellable = recordViewModel.getAllWorkoutBy(date: Date().currentFullDateString()).sink { completion in
            switch completion {
            case .finished:
                print("finished!")
            case .failure(let error):
                print("error: \(error.localizedDescription)")
            }
        } receiveValue: { workout in
            print(workout)
        }
    }
    
    func setCalendar() {
        
    }
    
    func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordViewCell.self, forCellReuseIdentifier: "RecordViewCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func toRecordCreateView() {
        let createView = RecordCreateView()
        navigationController?.pushViewController(createView, animated: true)
    }
}

extension RecordView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordViewCell", for: indexPath) as? RecordViewCell else {
            return UITableViewCell()
        }
        
        cell.subCategoryLabel.text = "Test Category"
        cell.repsLabel.text = "Test Reps"
        cell.weightLabel.text = "Test Weights"
        
        return cell
    }
}

/*
    private var cancellables = Set<AnyCancellable>()

    @objc func toRecordCreateView() {
        recordViewModel.getTestWorkout().subscribe(WorkoutSubscriber())
    }

    class WorkoutSubscriber: Subscriber {
        typealias Input = Workout
        typealias Failure = Error

        func receive(completion: Subscribers.Completion<Error>) {
            print("데이터 받기 완료!")
        }

        func receive(subscription: any Subscription) {
            subscription.request(.unlimited)
        }

        func receive(_ input: Workout) -> Subscribers.Demand {
            print("receivedValue: \(input.key)")
            return .none
        }
    }
*/
