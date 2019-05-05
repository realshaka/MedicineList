//
//  AppDelegate.swift
//  MedicineList
//
//  Created by Tan Nguyen on 04/05/2019.
//  Copyright © 2019 Tan Nguyen. All rights reserved.
//

import Foundation
struct Medicine : Decodable {
	let medicine_name : String?
	let total_pills_in_sheet : Int?
	let medicine_group : Int?
	let atc : String?
	let medicine_country : String?
	let safe_margin : Int?
	let pill_type : String?
	let hormonal_pills : Int?
	let placebo_pills : Int?

  /**init(medicine_name : String, total_pills_in_sheet : Int, medicine_group : Int, atc : String, medicine_country : String,safe_margin : Int, pill_type : String, hormonal_pills : Int, placebo_pills : Int) {
    self.medicine_name = medicine_name
    self.total_pills_in_sheet = total_pills_in_sheet
    self.medicine_group = medicine_group
    self.atc = atc
    self.medicine_country = medicine_country
    self.safe_margin = safe_margin
    self.pill_type = p
  }
   }**/
	enum CodingKeys: String, CodingKey {

		case medicine_name = "medicine_name"
		case total_pills_in_sheet = "total_pills_in_sheet"
		case medicine_group = "medicine_group"
		case atc = "atc"
		case medicine_country = "medicine_country"
		case safe_margin = "safe_margin"
		case pill_type = "pill_type"
		case hormonal_pills = "hormonal_pills"
		case placebo_pills = "placebo_pills"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		medicine_name = try values.decodeIfPresent(String.self, forKey: .medicine_name)
		total_pills_in_sheet = try values.decodeIfPresent(Int.self, forKey: .total_pills_in_sheet)
		medicine_group = try values.decodeIfPresent(Int.self, forKey: .medicine_group)
		atc = try values.decodeIfPresent(String.self, forKey: .atc)
		medicine_country = try values.decodeIfPresent(String.self, forKey: .medicine_country)
		safe_margin = try values.decodeIfPresent(Int.self, forKey: .safe_margin)
		pill_type = try values.decodeIfPresent(String.self, forKey: .pill_type)
		hormonal_pills = try values.decodeIfPresent(Int.self, forKey: .hormonal_pills)
		placebo_pills = try values.decodeIfPresent(Int.self, forKey: .placebo_pills)
	}
}


