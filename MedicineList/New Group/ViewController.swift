//
//  ViewController.swift
//  MedicineList
//
//  Created by Tan Nguyen on 04/05/2019.
//  Copyright © 2019 Tan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

  @IBOutlet var tableView: UITableView!
  
  var medList = [Medicine]()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    let url = URL(string: "https://connect.popit.io/download.php?filetype=medlist") 
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      guard let data = data else {
        print("Error: \(String(describing: error))")
        return
      }
      
      let listWrapper = try! JSONDecoder().decode(Data.self, from: data)
      self.medList = listWrapper.medicines
      DispatchQueue.main.async {
   
        self.tableView.reloadData()
      }

      print(self.medList.count)
      }
    task.resume()

  }
  

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return medList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as? MedicineCell else {return UITableViewCell()}
    let medicineForRow = self.medList[indexPath.row]
    cell.medicine = medicineForRow
    //self.cell.medName?.text = medicineForRow.medicine_name!
    //self.cell.medATC?.text = medicineForRow.atc!
    return cell
  }
  
}


