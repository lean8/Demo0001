//
//  ViewController.swift
//  Demo0001
//
//  Created by lean on 2021/9/2.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myTableView: UITableView!
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var showList: [ShowData] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.safeAreaLayoutGuide
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        setupTableView()
        
        let anonymousFunction = { (fetchShowList: [ShowData]) in
            DispatchQueue.main.async {
                self.showList = fetchShowList
                self.myTableView.reloadData()
            }
        }
        
        ShowAPI.shared.fetchShowList(onCompletion: anonymousFunction)
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        myTableView.delegate = self
        myTableView.dataSource = self
        scrollViewDidScroll(myTableView)
    }
    
    // MARK: - Setup View
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
//MARK: - UITableViewDataSource

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
//      performSegue(withIdentifier: "showDetail", sender: self)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowTableViewCell
        
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
