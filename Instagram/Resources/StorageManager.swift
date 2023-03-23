//
//  StorageManager.swift
//  Instagram
//
//  Created by 정주호 on 17/03/2023.
//

import FirebaseStorage

public class StorageManager {
    

    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    
    // MARK: - Public
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }

}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
