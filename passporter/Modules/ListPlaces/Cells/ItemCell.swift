//
//  SearchCell.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    func configure(item: PlaceModel?) {
        mainView.layer.borderColor = UIColor.lightGray.cgColor
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1
        mainImageView.layer.cornerRadius = 10
        titleLabel.text = item?.name
        subTitleLabel.text = item?.address
        let network = Network()
        network.getImage(url: item?.cover ?? "") { data in
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data ?? Data())
            }
        }
    }
}
