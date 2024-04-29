//
//  ViewController.swift
//  PostDemo
//
//  Created by Sahil Garg on 29/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        viewModel.delegate = self
        viewModel.fetch()
    }

}

extension ViewController: ViewModelProtocol {
    
    func updateUI() {
        postTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.showPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else { return UITableViewCell() }
        cell.cellModel = viewModel.showPosts[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController  = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.postModel = viewModel.showPosts[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

extension ViewController: UIScrollViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !viewModel.isLoadingList) {
            viewModel.loadMoreItemsForList()
        }
    }
    
}
