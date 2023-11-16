//
//  TransactionsView.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//


import UIKit
import SnapKit
import Then


class TransactionsView: BaseView {
    
    private let vTitle = UIView()
    
    private let lblTitle = UILabel().then {
        $0.text = "Activity"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    private let btnBell = UIButton().then {
        let image = UIImage(systemName: "bell")
        $0.setImage(image, for: .normal)
    }
    
    private let svMother = UIScrollView()
    
    private let svStack = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let vChart = ChartView()
    
    private let vList = ListView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let titleViews = [
            lblTitle, btnBell
        ]
        
        vTitle.addSubviews(titleViews)
        
        let arrangedSubviews = [
            vChart, vList
        ]
        
        svStack.addArrangedSubviews(arrangedSubviews)
        
        svMother.addSubview(svStack)
        
        let views = [
            vTitle, svMother
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        vTitle.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(vTitle).inset(15)
        }
        
        btnBell.snp.makeConstraints { make in
            make.centerY.equalTo(lblTitle)
            make.right.equalTo(vTitle).inset(15)
            make.width.height.equalTo(25)
        }
        
        svMother.snp.makeConstraints { make in
            make.top.equalTo(vTitle.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        svStack.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.bottom.equalTo(svMother)
        }
    }
}
