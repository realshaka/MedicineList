//
//  AppDelegate.swift
//  MedicineList
//
//  Created by Tan Nguyen on 04/05/2019.
//  Copyright © 2019 Tan Nguyen. All rights reserved.
//


import Foundation
struct Data: Decodable{
  
	let version : Int?
  let medicineGroup: [[String:String]]?
	let medicines : [Medicine]

	enum CodingKeys: String, CodingKey {

		case version = "version"
		case medicineGroup = "medicine_group"
		case medicine = "medicine"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		version = try values.decodeIfPresent(Int.self, forKey: .version)
    medicineGroup = try values.decodeIfPresent([[String:String]].self, forKey: .medicineGroup)
    medicines = try (values.decodeIfPresent([Medicine].self, forKey: .medicine))!
	}
}

