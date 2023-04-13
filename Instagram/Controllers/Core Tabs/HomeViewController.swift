//
//  ViewController.swift
//  Instagram
//
//  Created by 정주호 on 17/03/2023.
//

import FirebaseAuth
import UIKit

struct HomeFeedRanderViewModel {
    let hearder: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRanderViewModel]()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        //Register cells
        tv.register(IGFeedPostTableViewCell.self,
                    forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tv.register(IGFeedPostHeaderTableViewCell.self,
                    forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tv.register(IGFeedPostActionsTableViewCell.self,
                    forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tv.register(IGFeedPostGeneralTableViewCell.self,
                    forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNoAuthenticated()
    }
    
    //check auth status
    private func handleNoAuthenticated() {
        //만약 auth에 저장된 계정이 없다면,
        if Auth.auth().currentUser == nil {
            //show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
        
        return cell
    }
    
    
}
