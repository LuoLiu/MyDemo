//
//  ViewController.swift
//  TableViewDemo
//
//  Created by LuoLiu on 16/7/21.
//  Copyright © 2016年 LuoLiu. All rights reserved.
//

import UIKit

private let kNormalCellNibName          = "NormalCell"
private let kNormalCellIdentifier       = "idCellNormal"
private let kTextfieldCellNibName       = "TextfieldCell"
private let kTextfieldCellIdentifier    = "idCellTextfield"
private let kDatePickerCellNibName      = "DatePickerCell"
private let kDatePickerCellIdentifier   = "idCellDatePicker"
private let kSwitchCellNibName          = "SwitchCell"
private let kSwitchCellIdentifier       = "idCellSwitch"
private let kValuePickerCellNibName     = "ValuePickerCell"
private let kValuePickerCellIdentifier  = "idCellValuePicker"
private let kSliderCellNibName          = "SliderCell"
private let kSliderCellIdentifier       = "idCellSlider"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {

    var cellDescriptors: NSMutableArray!
    var visibleRowsPerSection = [[Int]]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        loadCellDescriptors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Custom Method
    private func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        tableView.registerNib(UINib(nibName: kNormalCellNibName, bundle: nil), forCellReuseIdentifier: kNormalCellIdentifier)
        tableView.registerNib(UINib(nibName: kTextfieldCellNibName, bundle: nil), forCellReuseIdentifier: kTextfieldCellIdentifier)
        tableView.registerNib(UINib(nibName: kDatePickerCellNibName, bundle: nil), forCellReuseIdentifier: kDatePickerCellIdentifier)
        tableView.registerNib(UINib(nibName: kSwitchCellNibName, bundle: nil), forCellReuseIdentifier: kSwitchCellIdentifier)
        tableView.registerNib(UINib(nibName: kValuePickerCellNibName, bundle: nil), forCellReuseIdentifier: kValuePickerCellIdentifier)
        tableView.registerNib(UINib(nibName: kSliderCellNibName, bundle: nil), forCellReuseIdentifier: kSliderCellIdentifier)
    }

    private func loadCellDescriptors() {
        if let path = NSBundle.mainBundle().pathForResource("CellDescriptor", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)
            getIndicesOfVisibleRows()
            tableView.reloadData()
            print(cellDescriptors)
        }
    }
    
    private func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }
    
    private func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        
        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()
            
            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cellDescriptors == nil ? 0 : cellDescriptors.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(currentCellDescriptor["cellIdentifier"] as! String, forIndexPath: indexPath) as! CustomCell

        if let cellIdentifier = currentCellDescriptor["cellIdentifier"] as? String {
            switch cellIdentifier {
            case kNormalCellIdentifier:
                if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                    cell.textLabel?.text = primaryTitle as? String
                }
                if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
                    cell.detailTextLabel?.text = secondaryTitle as? String
                }
            case kTextfieldCellIdentifier:
                cell.textField.placeholder = currentCellDescriptor["primaryTitle"] as? String
            case kSwitchCellIdentifier:
                cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
                let value = currentCellDescriptor["value"] as? String
                cell.swMaritalStatus.on = (value == "true") ? true : false
            case kValuePickerCellIdentifier:
                cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
            case kSliderCellIdentifier:
                let value = currentCellDescriptor["value"] as! String
                cell.slExperienceLevel.value = (value as NSString).floatValue
            default: break
            }
        }
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal"
        case 1:
            return "Preferences"
        default:
            return "Work Experience"
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case kNormalCellIdentifier:
            return 60.0
        case kDatePickerCellIdentifier:
            return 270.0
        default:
            return 44.0
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                shouldExpandAndShowSubRows = true
            }
            
            cellDescriptors[indexPath.section][indexOfTappedRow].setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
            }
        }
        
        getIndicesOfVisibleRows()
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Fade)
    }
    
    // MARK: CustomCellDelegate
    func dateWasSelected(selectedDateString: String) {
        //
    }

    func maritalStatusSwitchChangedState(isOn: Bool) {
        //
    }
    
    func textfieldTextWasChanged(newText: String, parentCell: CustomCell) {
        //
    }
    
    func sliderDidChangeValue(newSliderValue: String) {
        //
    }
}
