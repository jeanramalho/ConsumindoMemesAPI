//
//  MemesTableViewCell.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation
import UIKit

class MemesTableViewCell: UITableViewCell {
    
    lazy var memeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    lazy var memeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .orange
        label.numberOfLines = 0
        return label
    }()
    
    static let identifier: String = "MemesTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(memeImageView)
        addSubview(memeTitleLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            memeImageView.heightAnchor.constraint(equalToConstant: 60),
            memeImageView.widthAnchor.constraint(equalToConstant: 60),
            memeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            memeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            memeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            memeTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            memeTitleLabel.leadingAnchor.constraint(equalTo: memeImageView.trailingAnchor, constant: 12),
            memeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
        ])
    }
}
