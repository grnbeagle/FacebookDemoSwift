//
//  PhotoCell.swift
//  FacebookDemoSwift
//
//  Created by Amie Kweon on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    let reuseId = "PhotoCellReuseId"
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
}
