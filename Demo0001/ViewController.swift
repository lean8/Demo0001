//
//  ViewController.swift
//  Demo0001
//
//  Created by lean on 2021/9/2.
//

import UIKit

class ViewController: UIViewController {
    let myTableView = UITableView()
    var safeArea: UILayoutGuide!
    var showList: [ShowData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.safeAreaLayoutGuide
        setupTableView()
        let anonymousFunction = { (fetchShowList: [ShowData]) in
            DispatchQueue.main.async {
                self.showList = fetchShowList
                self.myTableView.reloadData()
            }
        }
        
        ShowAPI.shared.fetchShowList(onCompletion: anonymousFunction)
        let nib = UINib(nibName: "ShowTableViewCell", bundle: nil)
        myTableView.rowHeight = 120
        myTableView.estimatedRowHeight = 120
        myTableView.register(nib, forCellReuseIdentifier: "ShowTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        scrollViewDidScroll(myTableView)
    }
    
    // MARK: - Setup View
    func setupTableView() {
        view.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
//MARK: - UITableViewDataSource

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
//        let vc = self.storyboard?.instantiateViewController(identifier: "showDetail") as! DetailViewController
        performSegue(withIdentifier: "showDetail", sender: self)
//        present(vc, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let indexPath = myTableView.indexPathForSelectedRow{
                let item = segue.destination as! DetailViewController
                item.showData = showList[indexPath.row]
            }
        }
    }
}


extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell", for: indexPath) as! ShowTableViewCell
        
//        let showData = showList[indexPath.row]
//        cell.textLabel?.text = showData.title
        cell.showData = showList[indexPath.row]
        cell.setcell()
        return cell
    }
  
    //偵測是否滑到底部
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            let anonymousFunction = { (fetchShowList: [ShowData]) in
                DispatchQueue.main.async {
                    ShowAPI.shared.page += 1
                    self.showList.append(contentsOf: fetchShowList)
                }
            }
            myTableView.reloadData()
            ShowAPI.shared.fetchShowList(onCompletion: anonymousFunction)
        }
    }
}
