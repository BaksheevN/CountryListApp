//
//  CountryCell.swift
//  Walmart test
//
//  Created by Nikita Baksheev on 6/19/25.
//

import UIKit

class CountryCell: UITableViewCell {
    private let nameRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        
        codeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        codeLabel.adjustsFontForContentSizeCategory = true
        codeLabel.textAlignment = .right
        
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .body)
        capitalLabel.adjustsFontForContentSizeCategory = true
        
        let topStack = UIStackView(arrangedSubviews: [nameRegionLabel, codeLabel])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        
        let stack = UIStackView(arrangedSubviews: [topStack, capitalLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: CountryCellViewModel) {
        nameRegionLabel.text = viewModel.nameRegion
        codeLabel.text = viewModel.code
        capitalLabel.text = viewModel.capital
    }
}
