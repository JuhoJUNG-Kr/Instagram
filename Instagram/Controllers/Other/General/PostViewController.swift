//
//  PostViewController.swift
//  Instagram
//
//  Created by 정주호 on 17/03/2023.
//

import UIKit

/*
 Section
 - Header model
 Section
 - Post Cell model
 Section
 - Action button Cell model
 Section
 - Number of general models for comments
 
 */
//State of a rendered cell
enum PostRenderType {
    case header(provider: User)
    case primartContent(provider: UserPost) //Post
    case action(provider: String) //like, comment, share
    case comments(comments: [PostComment])
}

//Model of renderd Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

final class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
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
    
    // MARK: - Init
    
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else { return }
        //header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primartContent(provider: userPostModel)))

        //Actions
        renderModels.append(PostRenderViewModel(renderType: .action(provider: "")))

        //4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "@Dave",
                                        text: "test text",
                                        createdDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .action(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primartContent(_): return 1
        case .header(_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .action(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
            
        case .primartContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .action(_): return 60
            
        case .comments(_): return 50
            
        case .primartContent(_): return tableView.width

        case .header(_): return 70

        }
    }
    
}
