//
//  MedicineCell.swift
//  MedicineList
//
//  Created by Tan Nguyen on 04/05/2019.
//  Copyright © 2019 Tan Nguyen. All rights reserved.
//

import Foundation
import UIKit

class MedicineCell: UITableViewCell {
  @IBOutlet weak var medName: UILabel!
  @IBOutlet weak var medGroup: UILabel!
  @IBOutlet weak var medATC: UILabel!
  
  var medicine: Medicine? {
    didSet {
      medName.text = medicine?.medicine_name
      medATC.text = medicine?.atc
      //medGroup.text = String(medicine!.medicine_group)
    }
  }
  
  
  
}
