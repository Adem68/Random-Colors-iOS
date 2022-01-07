//
//  ColorDetailVC.swift
//  RandomColors
//
//  Created by Adem Özcan on 6.01.2022.
//

import UIKit
import Drops

class ColorDetailVC: UIViewController {

    var selectedColor: UIColor

    private var colorBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.setTitle("Color Code", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    init(color: UIColor){
        selectedColor = color
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colorBtn)
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = selectedColor
        self.navigationItem.title = selectedColor.accessibilityName.capitalized + " " + selectedColor.hexString
        colorBtn.addTarget(self, action: #selector(buttonTapped),for: .touchUpInside)
        colorBtn.setTitleColor(selectedColor, for: .normal)
        NSLayoutConstraint.activate([
            colorBtn.widthAnchor.constraint(equalToConstant: 150),
            colorBtn.heightAnchor.constraint(equalToConstant: 35),
            colorBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func buttonTapped() {
        ClipboardManager.showToast(with: selectedColor)
    }
}
