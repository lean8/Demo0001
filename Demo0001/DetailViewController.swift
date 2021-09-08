//
//  DetailViewController.swift
//  Demo0001
//
//  Created by lean on 2021/9/5.
//

import UIKit


class DetailViewController: UIViewController {

    var showData: ShowData?
    
    let imageView = UIImageView (frame: CGRect(x: 10, y: 100, width: 394, height: 296))
    let titleLabel = UILabel(frame: CGRect(x: 10 , y: 400, width: 394, height: 26.5))
    let typeLabel = UILabel(frame: CGRect(x: 20 , y: 443, width: 90, height: 30))
    let showTypeLabel = UILabel(frame: CGRect(x: 145 , y: 443, width: 248, height: 30))
    let episodesLabel = UILabel(frame: CGRect(x: 20 , y: 478, width: 90, height: 30))
    let showEpisodesLabel = UILabel(frame: CGRect(x: 145 , y: 478, width: 248, height: 30))
    let startDateLabel = UILabel(frame: CGRect(x: 20 , y: 513, width: 90, height: 30))
    let showStartDateLabel = UILabel(frame: CGRect(x: 145 , y: 513, width: 248, height: 30))
    let endDateLabel = UILabel(frame: CGRect(x: 20 , y: 548, width: 90, height: 30))
    let showEndDateLabel = UILabel(frame: CGRect(x: 145 , y: 548, width: 248, height: 30))
    let scoreLael = UILabel(frame: CGRect(x: 20 , y: 583, width: 90, height: 30))
    let showScoreLael = UILabel(frame: CGRect(x: 145 , y: 583, width: 248, height: 30))
    let urlLabel = UILabel(frame: CGRect(x: 20 , y: 618, width: 90, height: 30))
    let urlButton = UIButton(type: .system)

    //初始化imageView
    func imageViewInitial() {
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    //初始化Label
    func labelInitial() {
        //titleLabel 初始化
        titleLabel.numberOfLines = 0
        titleLabel.font = titleLabel.font.withSize(22)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        //typeLabel 初始化
        typeLabel.numberOfLines = 0
        typeLabel.font = titleLabel.font.withSize(22)
        typeLabel.textAlignment = .center
        typeLabel.text = "型別"
        view.addSubview(typeLabel)
        
        //showTypeLabel 初始化
        showTypeLabel.numberOfLines = 0
        showTypeLabel.font = titleLabel.font.withSize(22)
        showTypeLabel.textAlignment = .center
        view.addSubview(showTypeLabel)
        
        //episodesLabel 初始化
        episodesLabel.numberOfLines = 0
        episodesLabel.font = titleLabel.font.withSize(22)
        episodesLabel.textAlignment = .center
        episodesLabel.text = "情節"
        view.addSubview(episodesLabel)
        
        //showEpisodesLabel 初始化
        showEpisodesLabel.numberOfLines = 0
        showEpisodesLabel.font = titleLabel.font.withSize(22)
        showEpisodesLabel.textAlignment = .center
        view.addSubview(showEpisodesLabel)
        
        //startDateLabel 初始化
        startDateLabel.numberOfLines = 0
        startDateLabel.font = titleLabel.font.withSize(22)
        startDateLabel.textAlignment = .center
        startDateLabel.text = "上映日期"
        view.addSubview(startDateLabel)
        
        //showStartDateLabel 初始化
        showStartDateLabel.numberOfLines = 0
        showStartDateLabel.font = titleLabel.font.withSize(22)
        showStartDateLabel.textAlignment = .center
        view.addSubview(showStartDateLabel)
        
        //endDateLabel 初始化
        endDateLabel.numberOfLines = 0
        endDateLabel.font = titleLabel.font.withSize(22)
        endDateLabel.textAlignment = .center
        endDateLabel.text = "下映日期"
        view.addSubview(endDateLabel)
        
        //showEndDateLabel 初始化
        showEndDateLabel.numberOfLines = 0
        showEndDateLabel.font = titleLabel.font.withSize(22)
        showEndDateLabel.textAlignment = .center
        view.addSubview(showEndDateLabel)
        
        //scoreLael 初始化
        scoreLael.numberOfLines = 0
        scoreLael.font = titleLabel.font.withSize(22)
        scoreLael.textAlignment = .center
        scoreLael.text = "評分"
        view.addSubview(scoreLael)
        
        //showScoreLael 初始化
        showScoreLael.numberOfLines = 0
        showScoreLael.font = titleLabel.font.withSize(22)
        showScoreLael.textAlignment = .center
        view.addSubview(showScoreLael)
        
        //urlLabel 初始化
        urlLabel.numberOfLines = 0
        urlLabel.font = titleLabel.font.withSize(22)
        urlLabel.textAlignment = .center
        urlLabel.text = "網址"
        view.addSubview(urlLabel)
        
    }
    
    //urlButton初始化
    func buttonInitial() {
        urlButton.frame = CGRect(x: 145, y: 618, width: 248, height: 30)
        urlButton.setTitle("點我", for: .normal)
        urlButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        urlButton.titleLabel?.textAlignment = .center
        urlButton.addTarget(self, action: #selector (DetailViewController.tapButton(_:)), for: UIControl.Event.touchUpInside)
        
        view.addSubview(urlButton)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewInitial()
        labelInitial()
        buttonInitial()
        
        titleLabel.text = showData?.title
        showTypeLabel.text = showData?.type
        showEpisodesLabel.text = "\(showData!.episodes ?? 0)"
        showStartDateLabel.text = showData?.start_date
        showEndDateLabel.text = showData?.end_date
        showScoreLael.text = "\(showData!.score ?? 0)"
       
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
 
    @objc func tapButton(_ sender: Any) {
        if let url = URL(string: "\(showData?.url ?? "")"){
            UIApplication.shared.open(url, options: [:])
        }else{
            print("錯誤url")
        }
    }
    
}
