//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by 정주호 on 24/03/2023.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .systemBlue
        btn.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return btn
    }()
    
    private let tagButton: UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .lightGray
        btn.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(tagButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTagButton() {
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.padding,
                                  width: size,
                                  height: size)
        tagButton.frame = CGRect(x: gridButtonX + (width/2),
                                 y: Constants.padding,
                                 width: size,
                                 height: size)
    }
}
