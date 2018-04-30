//
//  NewsTableViewCell.swift
//  NewsSample
//
//  Created by mac on 2018. 4. 30..
//  Copyright © 2018년 StudioKJ. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsImageLabel: UIImageView!
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurateTheCell(info : Article) {
        if let imageLink = info.urlToImage{
            self.newsImageLabel!.kf.setImage(with: URL(string: imageLink))
        }
        self.newsTitleLabel.text = info.title
        self.newsContentLabel.text = info.description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
