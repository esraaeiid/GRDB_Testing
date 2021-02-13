//
//  FriendViewController.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 12/02/2021.
//

import UIKit

class FriendViewController: UITableViewController, Storyboarded{
    
    weak var coordinator: MainCoordinator?
    var friend: Friend!
    
    var timeZones = [TimeZone]()
    var selectedTimeZone = 0
    
    var nameEditingCell: TextTableViewCell?{
        let indexPath = IndexPath(row: 0, section: 0)
        return tableView.cellForRow(at: indexPath) as? TextTableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let identifiers = TimeZone.knownTimeZoneIdentifiers
        
        for identifier in identifiers {
            if let timeZone = TimeZone(identifier: identifier){
                timeZones.append(timeZone)
            }
        }
        
        let now = Date()
       
        
        timeZones.sort{
            let ourDiff = $0.secondsFromGMT(for: now)
            let otherDiff = $1.secondsFromGMT(for: now)
            
            if ourDiff == otherDiff {
                return $0.identifier < $1.identifier
            }
            else{
                return ourDiff < otherDiff
            }
        }
        
        selectedTimeZone = timeZones.firstIndex(of: friend.timeZone) ?? 0
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated )
        coordinator?.update(friend: friend)
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        friend.name = sender.text ?? ""
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return timeZones.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Name your friend"
        }
        else{
            return "Select their timezone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as? TextTableViewCell else {
                fatalError("Couldn't find text cell")
            }
            cell.txtFiled.text = friend.name
            return cell
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZone", for: indexPath)
            
            let timeZone = timeZones[indexPath.row]
            
            cell.textLabel?.text = timeZone.identifier.replacingOccurrences(of: "_", with: " ")
                let timeDiff = timeZone.secondsFromGMT(for: Date())
            cell.detailTextLabel?.text = String(timeDiff.timeString())
            
            if indexPath.row == selectedTimeZone {
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            
            return cell
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            startEditingName()
        }
        else{
            selectRow(at: indexPath)
        }
    }
    
    func startEditingName(){
        nameEditingCell?.txtFiled.becomeFirstResponder()
    }
    
    func selectRow(at indexPath: IndexPath){
        nameEditingCell?.txtFiled.resignFirstResponder()
        for cell in tableView.visibleCells {
            cell.accessoryType = .none
        }
        selectedTimeZone = indexPath.row
        friend.timeZone = timeZones[indexPath.row]
        
        let selected = tableView.cellForRow(at: indexPath)
        selected?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
}
