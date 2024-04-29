//
//  ViewModel.swift
//  PostDemo
//
//  Created by Sahil Garg on 29/04/24.
//

import Foundation

protocol ViewModelProtocol {
    func updateUI()
}

final class ViewModel {
    
    var delegate: ViewModelProtocol?
    
    var totalPosts: [PostModel] = []
    var showPosts: [PostModel] = []
    var totalPages : Int = 0
    var currentPage : Int = 0
    var isLoadingList : Bool = false
    
    func fetch() {
        APIManager.shared.fetchData { response in
            DispatchQueue.main.async {
                self.isLoadingList = false
                switch response {
                case .success(let products):
                    self.totalPosts = products
                    self.totalPages = self.totalPosts.count/20
                    if self.totalPosts.count % 20 != 0 {
                        self.totalPages += 1
                    }
                    for i in 0 ..< (self.totalPosts.count < 20 ? self.totalPosts.count : 20) {
                        self.showPosts.append(self.totalPosts[i])
                    }
                    self.delegate?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadMoreItemsForList() {
        if currentPage < self.totalPages {
            self.isLoadingList = true
            currentPage += 1
            for i in currentPage*20 ..< (self.totalPosts.count < (currentPage+1)*20 ? self.totalPosts.count : (currentPage+1)*20) {
                self.showPosts.append(self.totalPosts[i])
            }
            self.delegate?.updateUI()
        }
        self.isLoadingList = false
    }
    
}
