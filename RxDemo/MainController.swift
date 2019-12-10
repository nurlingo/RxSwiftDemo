//
//  MainController.swift
//  RxDemo
//
//  Created by Nursultan on 20/11/2019.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import UIKit
import RxSwift

class MainControler: UIViewController {
        
    let disposeBag = DisposeBag()
    
    var habits: [Habit] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setupViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNew))
        
        tableView.register(HabitCell.classForCoder(), forCellReuseIdentifier: String(describing: HabitCell.self))
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 63
    }
    
    func setupViews() {
        
        self.view.addSubview(tableView)
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func openNew() {
        let addHabitController = AddHabitController()
        addHabitController.habitTitle.subscribe(onNext: { [weak self] (habitTitle) in
            let habit = Habit(title: habitTitle)
            self?.habits.append(habit)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.navigationController?.pushViewController(addHabitController, animated: true)
    }
    
}

extension MainControler: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitCell.self), for: indexPath) as! HabitCell
        let habit = habits[indexPath.row]
        cell.titleLabel.text = habit.title
        return cell
    }
    
}
