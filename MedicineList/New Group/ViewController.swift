//
//  ViewController.swift
//  MedicineList
//
//  Created by Tan Nguyen on 04/05/2019.
//  Copyright © 2019 Tan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  //Mark: SubView
  @IBOutlet var InfoView: UIView!
  @IBOutlet weak var MedName: UILabel!
  @IBOutlet weak var MedTotal: UILabel!
  @IBOutlet weak var MedGroup: UILabel!
  @IBOutlet weak var MedATC: UILabel!
  @IBOutlet weak var MedCountry: UILabel!
  @IBOutlet weak var MedMargin: UILabel!
  @IBOutlet weak var MedType: UILabel!
  @IBOutlet weak var MedHormonal: UILabel!
  @IBOutlet weak var MedPlacebo: UILabel! 
  @IBAction func CloseInfos(_sender : UIButton) {
    InfoView.removeFromSuperview()
  }
  
  
  var medList = [Medicine]()
  var currentMedList = [Medicine]()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    let url = URL(string: "https://connect.popit.io/download.php?filetype=medlist") 
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      guard let data = data else {
        print("Error: \(String(describing: error))")
        return
      }
      let listWrapper = try! JSONDecoder().decode(Data.self, from: data)
      self.medList = listWrapper.medicines
      self.currentMedList = self.medList
      DispatchQueue.main.async {
        self.tableView.reloadData()
        //self.currentMedList = self.medList
      }
      print(self.medList.count)
      }
    task.resume()
  }
  
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentMedList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as? MedicineCell else {return UITableViewCell()}
    let medicineForRow = self.medList[indexPath.row]
    cell.medicine = medicineForRow
    //self.cell.medName?.text = medicineForRow.medicine_name!
    //self.cell.medATC?.text = medicineForRow.atc!
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let infos = self.medList[indexPath.row]
    MedName.text = infos.medicine_name
    MedTotal.text = "\(String(describing: infos.total_pills_in_sheet))"
    MedATC.text = infos.atc
    MedCountry.text = infos.medicine_country ?? "updating"
    MedMargin.text = "\(infos.safe_margin!/3600) hour(s) \(infos.safe_margin!/60) minutes"
    MedType.text = infos.pill_type
    MedHormonal.text = String(infos.hormonal_pills ?? 0)
    MedPlacebo.text = String(infos.hormonal_pills ?? 0)
    InfoView.center = view.center
    view.addSubview(InfoView)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard !searchText.isEmpty else {
      currentMedList = medList 
      tableView.reloadData()
      return
    }
    currentMedList = medList.filter({medicine -> Bool in medicine.medicine_name!.lowercased().contains(searchText.lowercased())
      })
    tableView.reloadData()  
    }
    
}


