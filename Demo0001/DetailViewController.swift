//
//  DetailViewController.swift
//  Demo0001
//
//  Created by lean on 2021/9/5.
//

import UIKit


class DetailViewController: UIViewController {

    var showData: ShowData?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var episodesLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var scoreLael: UILabel!
    @IBOutlet var urlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = showData?.title
        typeLabel.text = showData?.type
        episodesLabel.text = String(format: "無資料", showData!.episodes ?? "")
        startDateLabel.text = showData?.start_date
        endDateLabel.text = showData?.end_date
        scoreLael.text = String(format: "無資料", showData!.score ?? "")
       
        if let urlStr = URL(string: showData?.image_url ?? "") {
                URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            // 得到圖片
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
    }
 
    @IBAction func tapButton(_ sender: Any) {
        if let url = URL(string: "\(showData?.url ?? "")"){
            UIApplication.shared.open(url, options: [:])
        }else{
            print("錯誤url")
        }
    }
    
}
