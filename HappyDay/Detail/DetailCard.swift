//
//  DetailCard.swift
//  HappyDay
//
//  Created by judongseok on 2022/05/08.
//

import UIKit
import SnapKit

enum CardType {
    case send
    case receive
}

class CardView: UIView {
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, type: CardType) {
        super.init(frame: frame)
        
        if type == .send {
            setLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ui setting
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020년 2월 20일"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "홍길동 결혼식"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "50000원"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: - layout setting
    private func setLayout() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 20
        
        self.addSubview(dateLabel)
        self.addSubview(contentLabel)
        self.addSubview(priceLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.leading.equalTo(15)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.leading.equalTo(15)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(15)
        }
    }
}
