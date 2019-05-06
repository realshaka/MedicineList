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
  
  //Mark: no Med view
  @IBOutlet var noMedView: UIView!
  @IBAction func closeNoMedView(_ sender: Any) {
    noMedView.removeFromSuperview()
  }
  
  
  //Mark: Loadingview
  @IBOutlet weak var LoadingView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
  var medList = [Medicine]()
  var currentMedList = [Medicine]()
  var groupList = [[String:String]]()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    self.showLoadingView()
    tableView.backgroundView = noMedView
    noMedView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
    
    let url = URL(string: "https://connect.popit.io/download.php?filetype=medlist") 
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      guard let data = data else {
        print("Error: \(String(describing: error))")
        DispatchQueue.main.async {
          self.hideLoadingView()
          
          //self.currentMedList = self.medList
        }
        return
      }
      let listWrapper = try! JSONDecoder().decode(Data.self, from: data)
      self.medList = listWrapper.medicines
      self.currentMedList = self.medList
      self.groupList = listWrapper.medicineGroup!
      DispatchQueue.main.async {
        self.tableView.reloadData()
        
        //self.currentMedList = self.medList
      }
      print(self.medList.count)
      print(self.groupList)
    }
    task.resume()
    
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if tableView == self.tableView {
         
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentMedList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if currentMedList.count == 0 || currentMedList.isEmpty {
      view.addSubview(noMedView)
      self.hideLoadingView()
      return tableView.dequeueReusableCell(withIdentifier: "noMedCell")!
      
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as? MedicineCell else {return UITableViewCell()}
      let medicineForRow = self.currentMedList[indexPath.row]
      cell.medicine = medicineForRow
      cell.medGroup.text = self.groupList[0]["\(medicineForRow.medicine_group!)"]
      self.hideLoadingView()
      return cell
      
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let infos = self.currentMedList[indexPath.row]
    MedName.text = infos.medicine_name
    MedTotal.text = "\(String(describing: infos.total_pills_in_sheet))"
    MedGroup.text = self.groupList[0]["\(infos.medicine_group!)"]
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
  
  func showLoadingView() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.LoadingView.alpha = 1
      self.activityIndicator.startAnimating()
    }, completion: nil)
  }
  func hideLoadingView() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.LoadingView.alpha = 0
      self.activityIndicator.stopAnimating()
    }, completion: nil)
  }
}


