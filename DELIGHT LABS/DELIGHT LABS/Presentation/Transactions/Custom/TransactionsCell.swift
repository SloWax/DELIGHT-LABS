//
//  TransactionsCell.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import UIKit
import SnapKit
import Then

class TransactionsCell: UITableViewCell {
    static let id: String = "TransactionsCell"
    
    private let ivImage = UIImageView().then {
        $0.backgroundColor = .lightGray
    }
    
    private let lblName = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let lblType = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let lblAmount = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    private let lblDate = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUP()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [
            ivImage,
            lblName, lblType,
            lblAmount, lblDate
        ]
        
        self.contentView.addSubviews(views)
    }
    
    private func setLayout() {
        ivImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.contentView).inset(5)
            make.left.equalTo(self.contentView).inset(15)
            make.width.height.equalTo(50)
        }
        
        lblName.snp.makeConstraints { make in
            make.left.equalTo(ivImage.snp.right).offset(15)
            make.bottom.equalTo(self.contentView.snp.centerY)
        }
        
        lblType.snp.makeConstraints { make in
            make.left.equalTo(lblName)
            make.top.equalTo(self.contentView.snp.centerY)
        }
        
        lblAmount.snp.makeConstraints { make in
            make.right.equalTo(self.contentView).inset(15)
            make.bottom.equalTo(self.contentView.snp.centerY)
        }
        
        lblDate.snp.makeConstraints { make in
            make.right.equalTo(lblAmount)
            make.top.equalTo(self.contentView.snp.centerY)
        }
    }
    
    func setValue(_ value: TransactionsModel) {
        lblName.text = value.name
        lblType.text = value.type
        lblAmount.text = "\(value.amount)".toDollar(value.isPositive)
        lblDate.text = value.time.toString()
    }
}
