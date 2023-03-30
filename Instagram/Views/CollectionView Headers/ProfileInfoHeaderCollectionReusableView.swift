//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by 정주호 on 24/03/2023.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject{
    func profileHearderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHearderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHearderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHearderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit your profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Juho Jung"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my first account!"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(bioLabel)
        addSubview(nameLabel)
        addSubview(editProfileButton)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postsButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5 + buttonHeight,
                                         width: countButtonWidth*3,
                                         height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width-10,
                                 height: 50).integral
        
        //bio에 글 숫자만큼 레이블 크기 변경
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(x: 5,
                                y: 5 + nameLabel.bottom,
                                width: width-10,
                                height: bioLabelSize.height).integral
    }
    
    // MARK: - Actions
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHearderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHearderDidTapFollowingButton(self)
    }
    
    @objc private func didTapPostButton() {
        delegate?.profileHearderDidTapPostsButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHearderDidTapEditProfileButton(self)
    }

    
    
}
