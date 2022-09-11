//
//  ViewController.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/6/22.
//

import UIKit


final class MissionListViewController: UIViewController {
    
    private var dataSource: UITableViewDiffableDataSource<Section,DomainMission>!
    
    private lazy var missionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.rowHeight = 170
        tableView.delegate = self
        tableView.alpha = 0
        tableView.setEmptyMessage()
        tableView.register(UINib(nibName: MissionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MissionTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - INITIALIZER
    private let viewModel: MissionListViewModel
    
    init(viewModel: MissionListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW CONTROLLER LIFECYCLE METHODS
    override func loadView() {
        super.loadView()
        title = "To The Mars!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat"), style: .plain, target: self, action: #selector(refreshData))
        view.backgroundColor = .systemBackground
        createUI()
        configureDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModelData()
    }
    
    //MARK: - UI SETUP
    private func createUI() {
        configureMainTableView()
    }
    
    private func configureMainTableView() {
        view.addSubview(missionsTableView)
        missionsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            missionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            missionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            missionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            missionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - BINDING METHODS
    private func bindingViewModelData() {
        viewModel.updateTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.missionsTableView.restore()
                self.createSnapshot(from: self.viewModel.getAllItems())
                UIView.animate(withDuration: 0.2, delay: 0.3) {
                    self.missionsTableView.alpha = 1
                }
            }
        }
        
        viewModel.enableRefreshButton = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        
        viewModel.showError = { [weak self] (message,buttonTitle) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: buttonTitle, style: .default) { action in
                    self.viewModel.retryGettingData()
                }
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension MissionListViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DomainMission>(tableView: missionsTableView, cellProvider: { [weak self] (tableView, indexPath, itemIdentifier) in
            if let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as? MissionTableViewCell {
                cell.domainMission = self?.viewModel.itemForRowAt(indexPath: indexPath)
                return cell
            } else {
                return UITableViewCell()
            }
        })
    }
    
    private func createSnapshot(from items: [DomainMission]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,DomainMission>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func refreshData() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        viewModel.refreshAllDate()
    }
}

//MARK: - TABLEVIEW DELEGATE
extension MissionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.2) {
            cell.alpha = 1
        }
        if indexPath.row == viewModel.numberOfRows() - 4 {
            viewModel.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.itemForRowAt(indexPath: indexPath)
        let destinationVC = MissionDetailsFactory(selectedItem: selectedItem).makeMissionDetailsViewController()
        show(destinationVC, sender: self)
    }
}

extension MissionListViewController {
    fileprivate enum Section {
        case main
    }
}
