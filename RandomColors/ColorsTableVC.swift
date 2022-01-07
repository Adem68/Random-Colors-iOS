//
//  ColorsTableVC.swift
//  RandomColors
//
//  Created by Adem Özcan on 6.01.2022.
//

import UIKit
import Drops

class ColorsTableVC: UIViewController {
    var colors: [UIColor] = []
    var safeArea: UILayoutGuide!
    let refreshControl = UIRefreshControl()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    enum Cells {
        static let colorCell = "ColorCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        safeArea = view.layoutMarginsGuide
        getColors()
        setupView()
        self.navigationItem.title = "Random Colors"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupView() {
        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cells.colorCell)
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        let longPressAction = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        tableView.addGestureRecognizer(longPressAction)
    }

    @objc func refreshControlAction() {
        getColors(isReloading: true)
    }

    @objc func longPressAction(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                ClipboardManager.showToast(with: colors[indexPath.row])
            }
        }
    }


    func getColors(isReloading: Bool = false) {
        colors.removeAll()
        for _ in 0..<50 {
            colors.append(.random())
        }
        if isReloading {
            self.refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
    }
}


extension ColorsTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.colorCell) else {
            return UITableViewCell()
        }
        let color = colors[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = color
        cell.textLabel?.text = "\(color.accessibilityName.capitalized) \(color.hexString)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        self.navigationController?.pushViewController(ColorDetailVC(color: color), animated: true)
    }
}
