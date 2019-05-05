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
  @IBOutlet weak var medName: UILabel?
  @IBOutlet weak var medGroup: UILabel?
  @IBOutlet weak var medATC: UILabel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  var medicine: Medicine? {
    didSet {
      //medGroup.text = String(medicine!.medicine_group)
      self.medName?.text = medicine?.medicine_name
      self.medATC?.text = medicine?.atc
      print(medicine?.medicine_name as Any)
      print(medicine?.atc as Any)
      if medicine?.atc == "G03" {
        medATC?.textColor = UIColor.red
      }
    }
  }

  
  
}
