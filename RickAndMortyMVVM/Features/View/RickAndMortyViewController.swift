//
//  RickAndMortyViewController.swift
//  RickAndMortyMVVM
//
//  Created by Machine on 11.04.2022.
//

import UIKit
import SnapKit

protocol RickAndMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickAndMortyViewController: UIViewController {

    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickAndMortyViewModel = RickAndMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    private func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()

    }
    
    private func drawDesign(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RickAndMortyCell.self, forCellReuseIdentifier: RickAndMortyCell.Identifier.custom.rawValue)
        tableView.rowHeight = 160
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.textColor = .black
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
            self.labelTitle.text = "Rick And Morty"
            self.indicator.color = .red
        }
        
        indicator.startAnimating()
    }
    
}

extension RickAndMortyViewController: RickAndMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}

extension RickAndMortyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: RickAndMortyCell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyCell.Identifier.custom.rawValue) as? RickAndMortyCell
        else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
}

extension RickAndMortyViewController {
        private func makeTableView(){
            tableView.snp.makeConstraints { make in
                make.top.equalTo(labelTitle.snp.bottom).offset(5)
                make.bottom.equalToSuperview()
                make.left.right.equalTo(labelTitle)
                
            }
        }
        
        private func makeLabel(){
            labelTitle.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
                make.left.equalTo(view).offset(10)
                make.right.equalTo(view).offset(-10)
                make.height.greaterThanOrEqualTo(10)
            }
        }
        
        private func makeIndicator(){
            indicator.snp.makeConstraints { make in
                make.height.equalTo(labelTitle)
                make.right.equalTo(labelTitle).offset(-5)
                make.top.equalTo(labelTitle)
                
            }
        }
    }
