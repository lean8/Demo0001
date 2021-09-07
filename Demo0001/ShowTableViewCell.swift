//
//  ShowTableViewCell.swift
//  Demo0001
//
//  Created by lean on 2021/9/3.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
  
    var showData:ShowData?

    @IBOutlet var showImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        setcell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setcell() {
            titleLabel.text = showData?.title
            scoreLabel.text = showData?.score?.description
        if let urlStr = URL(string: showData?.image_url ?? "") {
                URLSession.shared.dataTask(with: urlStr) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            // 得到圖片
                            self.showImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
    }
}
