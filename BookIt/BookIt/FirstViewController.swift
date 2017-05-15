//
//  FirstViewController.swift
//  BookIt
//
//  Created by Fawzi Hindi on 5/10/17.
//  Copyright © 2017 ARENV. All rights reserved.
//

import UIKit
import Foundation


class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate, reservationTableViewCellDelegate {

    //--------------------------------------------
    //--------------------------------------------
    // MARK:- HEADER
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    
    
    //--------------------------------------------
    // MARK: DEFINITIONS
    //--------------------------------------------
    
    
    
    //--------------------------------------------
    // MARK: PROPERTIES
    //--------------------------------------------
    
    
    //BACKGROUND ELEMENTS
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundBlur: UIVisualEffectView!
    
    
    
    //CALENDAR PANEL ELEMENTS
    @IBOutlet weak var calendarMasterContainer: UIView!
    @IBOutlet weak var calendarContainerTopConstraintVisible: NSLayoutConstraint!
    @IBOutlet weak var calendarContainerTopConstraintHidden: NSLayoutConstraint!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarMonthSelectorPanelTrailingConstraintAtHidden: NSLayoutConstraint!
    @IBOutlet weak var calendarMonthSelectorPanelCenterXConstraintAtVisible: NSLayoutConstraint!
    
    @IBOutlet weak var selectedDateViewerCenterYConstraintVisible: NSLayoutConstraint!
    @IBOutlet weak var selectedDateViewerBottomConstraintHidden: NSLayoutConstraint!
    
    @IBOutlet weak var monthSelectorLabel: UILabel!
    
    
    
    @IBOutlet weak var selectDateButton: UIButton!
    
    
    @IBOutlet weak var currentlySelectedMonthLabel: UILabel!
    
    @IBOutlet weak var currentlySelectedDayLabel: UILabel!
    
    
    
    
    
    //CLOCK ELEMENTS
    var clockTimer = Timer()
    @IBOutlet weak var currentHourLabel: UILabel!
    @IBOutlet weak var currentMinuteLabel: UILabel!
    @IBOutlet weak var amPmLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    
    //ACTION PANEL ELEMENTS
    @IBOutlet weak var actionPanelMasterContainer: UIView!
    @IBOutlet weak var partyNameTextField: UITextField!
    @IBOutlet weak var partyTimeTextField: UITextField!
    @IBOutlet weak var partyTableTextField: UITextField!
    @IBOutlet weak var sizeSelectorPickerView: UIPickerView!
    let monthLabels : [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    @IBOutlet weak var fulfillButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    
    
    //RESERVATION PANEL ELEMENTS
    @IBOutlet weak var reservationViewerMasterContainer: UIView!
    @IBOutlet weak var reservationViewerTrailingConstraintHidden: NSLayoutConstraint!
    @IBOutlet weak var reservationViewerTrailingConstraintVisible: NSLayoutConstraint!
    
    
    @IBOutlet weak var reservationViewerScrollView: UIScrollView!
    @IBOutlet weak var contentOfReservationViewerScrollView: UIView!
    @IBOutlet weak var tableHeaderReservationViewer: UIView!
    @IBOutlet weak var reservationViewerTableView: UITableView!
    
    
    
    
    //NAVBAR ELEMENTS
    @IBOutlet weak var navBarMasterContainer: UIView!
    @IBOutlet weak var navButtonHome: UIButton!
    @IBOutlet weak var navButtonReserve: UIButton!
    @IBOutlet weak var navButtonLiveFloor: UIButton!
    @IBOutlet weak var navBarContainerCenterYConstraintAtHomePosition: NSLayoutConstraint!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var liveFloorButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    
    
    //HOME PANEL ELEMENTS
    @IBOutlet weak var homePanelMasterContainer: UIView!
    @IBOutlet weak var homePanelLeftConstraintAtVisible: NSLayoutConstraint!
    @IBOutlet weak var homePanelLeftConstraintAtHidden: NSLayoutConstraint!
    @IBOutlet weak var homePanelBlur: UIVisualEffectView!
    var homePositionState: Bool = true
    
    
    
    
    //LIVEFLOOR PANEL ELEMENTS
    @IBOutlet weak var liveFloorMasterContainer: UIView!
    @IBOutlet weak var liveFloorCenterYConstraintVisible: NSLayoutConstraint!
    @IBOutlet weak var liveFloorBottomConstraintHidden: NSLayoutConstraint!
    
    
    
    //SEARCH PANEL ELEMENTS
    @IBOutlet weak var searchPanelMasterContainer: UIView!
    @IBOutlet weak var searchPanelCenterYConstraintVisible: NSLayoutConstraint!
    @IBOutlet weak var searchPanelTopConstraintHidden: NSLayoutConstraint!
    
    
    
    
    
    
    
    
    let beigeTone : UIColor = UIColor.init(red: 1, green: 0.98, blue: 0.89, alpha: 1)
    let beigeToneTransparent : UIColor = UIColor.init(red: 1, green: 0.98, blue: 0.89, alpha: 0.3)
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- DATA ELEMENTS
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    var reservationData = FHDataController.sharedInstance.accessMasterArray()
    var dateSelection : String?
    var currentTableBeingEdited : tableObject?
    var currentReservationBeingEdited : reservationObject?
    let formatOfDate = "MM-dd-yyy"
    var monthSelectionIndex : Int?
    var daysOfSelectedMonth : Int = 30
    var beginningWeekdayOfSelectedMonth : Int = 1
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- INITIALIZATION
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    //--------------------------------------------
    // viewDidLoad
    //--------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        //LOAD DATA
        FHDataController.sharedInstance.loadMasterArray()
        
        
        //redundant
        reservationData = FHDataController.sharedInstance.accessMasterArray()
        
        
        //SETUP GENERAL INTERFACE ELEMENTS
        setupGeneralInterfaceElements()
        
        prepCalendarCollectionView()
        
        prepClock()
        
        
        
    }

   
    //--------------------------------------------
    // viewWillAppear
    //--------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //SETUP RUNTIME VISUAL ELEMENTS
        setupRunTimeVisualElements()
        
    }
    
    
    
    
    //--------------------------------------------
    // viewDidAppear
    //--------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //REBOOT RESERVATION TABLE
        reservationViewerTableView.reloadData()
        
        
    }
    
    
    //--------------------------------------------
    // prefersStatusBarHidden
    //--------------------------------------------
    override var prefersStatusBarHidden: Bool{
        
        
        //HIDE STATUS BAR
        return true;
        
    }
    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- INTERFACE CUSTOMIZATIONS
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    
    
    //--------------------------------------------
    // setupGeneralInterfaceElements()
    //--------------------------------------------
    func setupGeneralInterfaceElements(){
        

        let blackTransparent : UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        let redTransparent : UIColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.4)
        let blueTransparent : UIColor = UIColor.init(red: 0, green: 0, blue: 0.8, alpha: 0.4)
        let greenTransparent : UIColor = UIColor.init(red: 0, green: 0.5, blue: 0, alpha: 0.4)
        
        calendarMasterContainer.backgroundColor = .clear
        calendarMasterContainer.alpha = 1
        
    
        actionPanelMasterContainer.backgroundColor = .clear
        actionPanelMasterContainer.alpha = 1
        
        
        reservationViewerMasterContainer.backgroundColor = .clear
        reservationViewerMasterContainer.alpha = 1
    
        
        
        navBarMasterContainer.backgroundColor = UIColor.clear;
        
        
        
        
        
        backgroundImageView.image = UIImage(named: "RESTAURANT_A.jpeg")
        backgroundImageView.alpha = 1
        backgroundBlur.alpha = 0;
        
        
        
        navButtonHome.backgroundColor = UIColor.red
        navButtonReserve.backgroundColor = UIColor.green
        navButtonLiveFloor.backgroundColor = UIColor.darkGray
        
        
        
        
 
        homePanelMasterContainer.backgroundColor = UIColor.clear
        
       
        
        
        liveFloorMasterContainer.backgroundColor = redTransparent
        liveFloorMasterContainer.layer.cornerRadius = 800;
        
        
        
        searchPanelMasterContainer.backgroundColor = blueTransparent
        searchPanelMasterContainer.layer.cornerRadius = 800
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        
        
        
        
        partyNameTextField.attributedPlaceholder = NSAttributedString(string: "Reservation name...",
                                                               attributes: [NSForegroundColorAttributeName: beigeToneTransparent])
        
        partyNameTextField.backgroundColor = blackTransparent
        
        //ADD TARGET TO TEXTFIELD TO DETECT EDITING
        partyNameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        partyNameTextField.delegate = self
        
        
        
        
        partyTimeTextField.attributedPlaceholder = NSAttributedString(string: "",
                                                                      attributes: [NSForegroundColorAttributeName: beigeToneTransparent])
        partyTimeTextField.backgroundColor = blackTransparent
        partyTimeTextField.isUserInteractionEnabled = false
        
        
        
        
        partyTableTextField.attributedPlaceholder = NSAttributedString(string: "",
                                                                      attributes: [NSForegroundColorAttributeName: beigeToneTransparent])
        partyTableTextField.backgroundColor = blackTransparent
        
        partyTableTextField.isUserInteractionEnabled = false
        
        
        
        
        
        
        tableHeaderReservationViewer.backgroundColor = greenTransparent
    
        
        reservationViewerTableView.allowsSelection = false
        reservationViewerTableView.showsVerticalScrollIndicator = false
        reservationViewerTableView.showsHorizontalScrollIndicator = false
        
        
        
        preparePartySizeData()
        
        
        
        
        
        
        
        
        //TINT ALL BUTTONS
        var origImage = UIImage(named: "homeLogo")
        var tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        homeButton.setImage(tintedImage, for: .normal)
        homeButton.tintColor = beigeTone
        homeButton.backgroundColor = .clear
        homeButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        origImage = UIImage(named: "appLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        logoImage.image = tintedImage
        logoImage.backgroundColor = .clear
        logoImage.contentMode = .scaleAspectFit
        logoImage.tintColor = beigeTone
        
        
        
        origImage = UIImage(named: "settingsLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(tintedImage, for: .normal)
        settingsButton.tintColor = beigeTone
        settingsButton.backgroundColor = .clear
        settingsButton.imageView?.contentMode = .scaleAspectFit
        
        
        origImage = UIImage(named: "mainLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        reserveButton.setImage(tintedImage, for: .normal)
        reserveButton.tintColor = beigeTone
        reserveButton.backgroundColor = .clear
        reserveButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        
        origImage = UIImage(named: "liveFloorLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        liveFloorButton.setImage(tintedImage, for: .normal)
        liveFloorButton.tintColor = beigeTone
        liveFloorButton.backgroundColor = .clear
        liveFloorButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        origImage = UIImage(named: "searchLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        searchButton.setImage(tintedImage, for: .normal)
        searchButton.tintColor = beigeTone
        searchButton.backgroundColor = .clear
        searchButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        
        
        origImage = UIImage(named: "fulfillLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        fulfillButton.setImage(tintedImage, for: .normal)
        fulfillButton.tintColor = .green
        fulfillButton.backgroundColor = .clear
        fulfillButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        
        origImage = UIImage(named: "deleteLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        cancelButton.setImage(tintedImage, for: .normal)
        cancelButton.tintColor = .red
        cancelButton.backgroundColor = .clear
        cancelButton.imageView?.contentMode = .scaleAspectFit
        
        
        
        
        origImage = UIImage(named: "selectDateLogo")
        tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        selectDateButton.setImage(tintedImage, for: .normal)
        selectDateButton.tintColor = beigeTone
        selectDateButton.backgroundColor = .clear
        selectDateButton.imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // setupRunTimeVisualElements
    //--------------------------------------------
    func setupRunTimeVisualElements(){
        
        
        
        
        
        
        var i = 0
        repeat {
            
           
            //INITIALIZE VERTICAL COLUMNS
            let iterateImageView = UIImageView(frame: CGRect(x: i*200, y: 0, width: 200, height: Int(self.contentOfReservationViewerScrollView.frame.size.height)))
            
            
            let tableLabel = UILabel(frame: CGRect(x: i*200, y: 0, width: 200, height: Int(self.tableHeaderReservationViewer.frame.size.height)))
            
            tableLabel.textAlignment = .left
            tableLabel.backgroundColor = .clear
            tableLabel.textColor = beigeTone
            tableLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
            
            
            
            if i%2==0{
                //EVEN COLUMNS
               
                    
                    if (7+i)<12{
                        tableLabel.text = " \(7+i) AM"
                    }
                    else{
                        if (7+i-12) == 0{
                            tableLabel.text = " NOON"

                        }
                        else{
                            tableLabel.text = " \(7+i-12) PM"
 
                        }
                    }
                
                
                
                iterateImageView.backgroundColor = .clear
                

            }
            else{
                //ODD COLUMNS
                
                if (7+i)<12{
                    tableLabel.text = " \(7+i) AM"
                }
                else{
                    if (7+i-12) == 0{
                        tableLabel.text = " NOON"
                        
                    }
                    else{
                        tableLabel.text = " \(7+i-12) PM"
                        
                    }
                }
                
                
                iterateImageView.backgroundColor = beigeToneTransparent
            }
            
            
            
            //ADD COLUMNS TO MASTER VIEW
            self.contentOfReservationViewerScrollView.addSubview(iterateImageView)
            
            self.contentOfReservationViewerScrollView.insertSubview(iterateImageView, belowSubview: self.reservationViewerTableView)
            
            self.tableHeaderReservationViewer.addSubview(tableLabel)
            
        
            i += 1
            
            
        } while i <= 16
        
        
        
        
        
    }
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- TABLEVIEW MANAGEMENT
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    
    
    
    //--------------------------------------------
    // tableView( ,numberOfRowsInSection)
    //--------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        
        return reservationData.count
    }
    
    
    
    
    
    //--------------------------------------------
    // tableView( ,heightForRowAt)
    //--------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        
        return 50
    }
    
    
    
    
    
    
    //--------------------------------------------
    // tableView( ,cellForRowAt)
    //--------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        
        
        // create a new cell if needed or reuse an old one
        let cell:reservationTableViewCell = self.reservationViewerTableView.dequeueReusableCell(withIdentifier: "tableCell") as! reservationTableViewCell!
        
        // set the text from the data model
        if indexPath.row%2==0{
            cell.contentView.backgroundColor = .clear

        }
        else{
            cell.contentView.backgroundColor = beigeToneTransparent
        }
        
        
        
        let currentTable : tableObject = reservationData[indexPath.row] as! tableObject
        
        cell.clearReservationLabelsFromCell()
        cell.updateTableLabels(tableNumber: Int(currentTable.tableName)!)
        
        
        
        cell.delegate = self
        
        
        
        
        
        
        
        
        
        
        var reservationsForToday : [reservationObject] = []
        
        for iterateReservation in currentTable.arrayOfReservations {
            
            
            if iterateReservation.reservationDate == self.dateSelection{
                reservationsForToday.append(iterateReservation)
            }
            
            
        }
        
        
        cell.arrayOfReservations = reservationsForToday
        
        cell.buildRowWithTodayReservations()
        
        
        
        
        
        
        
        
        return cell
        
        
        
    }
    
    
    
    
    
    
    //--------------------------------------------
    // numberOfSections()
    //--------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1

    }
    
    

    
    
    
    
    
    
    //--------------------------------------------
    // didSelectReservation()
    //--------------------------------------------
    func didSelectReservation(cell : reservationTableViewCell, interval: Int){
        
        
        
        
        
        let currentIndexPath = reservationViewerTableView.indexPath(for: cell)
        
        let tableObject : tableObject = reservationData[currentIndexPath!.row] as! tableObject

        
        let currentReservation = tableObject.arrayOfReservations.first{$0.reservationTimeInterval == interval}
        
        currentTableBeingEdited = tableObject
        currentReservationBeingEdited = currentReservation
        
        
        populateReservationEditor()
        
    }
    
    
    
    
    
    
    //--------------------------------------------
    // didCreateReservation()
    //--------------------------------------------
    func didCreateReservation(cell : reservationTableViewCell, interval: Int){
        
        
        let currentIndexPath = reservationViewerTableView.indexPath(for: cell)
        let tableObject : tableObject = reservationData[currentIndexPath!.row] as! tableObject
        let table = tableObject.tableName
        
        
        //CREATE NEW RESERVTION
        let currentReservation : reservationObject = reservationObject(name: "Guest", size: 2, date: self.dateSelection!, table: "\(table)", timeInterval: interval)
        
        
        tableObject.arrayOfReservations.append(currentReservation)
        
        
        
        
        
        
        //FOR EDITING NAME AND PARTY NUMBER
        currentTableBeingEdited = tableObject
        currentReservationBeingEdited = currentReservation
        
        partyNameTextField.becomeFirstResponder()
        
        populateReservationEditor()
        
        
        
        //SAVE DATA
        FHDataController.sharedInstance.saveMasterArray()
        
        
    }
    
    
    
    
    
    
    //--------------------------------------------
    // overbookingWarning()
    //--------------------------------------------
    func overbookingWarning (){
    
        
        let alert = UIAlertController(title: "Caution!", message: "It's not good to overbook", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // textFieldDidChange()
    //--------------------------------------------
    func textFieldDidChange(textField: UITextField){
        
        
        currentReservationBeingEdited?.reservationName = textField.text!
        
        reservationViewerTableView.reloadData()
        
        //SAVE DATA
        FHDataController.sharedInstance.saveMasterArray()
    }
    
    
    
    
    
    
    //--------------------------------------------
    // populateReservationEditor()
    //--------------------------------------------
    func populateReservationEditor (){
        
        
        //PARTY NAME
        if currentReservationBeingEdited?.reservationName == "Guest"{
           partyNameTextField.text = ""
        }
        else{
            partyNameTextField.text = currentReservationBeingEdited?.reservationName
        }
        
        
        
        
        
        partyTableTextField.text = currentReservationBeingEdited?.reservationTable
        
        
        
        
        //CONVERT HOURS
        let hourConverter : Float = Float((currentReservationBeingEdited?.reservationTimeInterval)!)/4
        
        
        
        
        
        var hour : Int?
        var amPm : String?
        
        if hourConverter<5 {
            //AM HOURS
            
            hour = Int(hourConverter + 7.0)
            amPm = "AM"
            
            
        }
        else if hourConverter == 5 {
            hour = 12
            amPm = "PM"
        }
        else{
            
            hour = Int(hourConverter - 5)
            amPm = "PM"
            
        }
        
        
        
        
        
        
        
        //CONVERT MINUTES
        let timeInterval = currentReservationBeingEdited?.reservationTimeInterval
        
        //PASSES BACK THE NUMERATOR OF THE REMAINDER
        let minuteConverter = (timeInterval!)%4
        
        let minutes = Int(minuteConverter*15)
        let minutesAsString = String(format: "%02d", minutes)
        
        
        partyTimeTextField.text = "\(hour!):"+minutesAsString+" "+amPm!
        
        
        
        
        
        
        
        
        
        
        
        //DISPLAY PARTY SIZE
        sizeSelectorPickerView.selectRow((currentReservationBeingEdited?.reservationSize)!-1, inComponent: 0, animated: false)
        
        
    }
    
    
    
    //--------------------------------------------
    // clearReservationEditor()
    //--------------------------------------------
    func clearReservationEditor(){
        
        
        partyNameTextField.text = ""
        partyTableTextField.text = ""
        partyTimeTextField.text = ""
        
        currentReservationBeingEdited = nil
        currentTableBeingEdited = nil
        
        
        partyNameTextField.resignFirstResponder()
        
    }
    
    
    
    
    //--------------------------------------------
    // textFieldShouldBeginEditing()
    //--------------------------------------------
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if currentReservationBeingEdited != nil{
            return true
        }
        return false
    }
    
    
    
    //--------------------------------------------
    // didPressFulfillReservation()
    //--------------------------------------------
    @IBAction func didPressFulfillReservation(_ sender: Any) {
        
        
        currentReservationBeingEdited?.toggleFulfilledStatus()
        
        reservationViewerTableView.reloadData()
        
        
        //SAVE DATA
        FHDataController.sharedInstance.saveMasterArray()
        
    }
    
    
    
    
    
    //--------------------------------------------
    // didPressCancelReservation()
    //--------------------------------------------
    @IBAction func didPressCancelReservation(_ sender: Any) {

    
        
        
        if let index = currentTableBeingEdited?.arrayOfReservations.index(where: { $0.reservationTimeInterval == currentReservationBeingEdited?.reservationTimeInterval }) {
            

            currentTableBeingEdited?.arrayOfReservations.remove(at: index)
        
        
        }
        
        
        
        clearReservationEditor()
        reservationViewerTableView.reloadData()
        
        //SAVE DATA
        FHDataController.sharedInstance.saveMasterArray()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- USER INTERACTION
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    //--------------------------------------------
    // didPressNavBarButton()
    //--------------------------------------------
    @IBAction func didPressNavBarButton(_ sender: UIButton) {
        //--------------
        //TAG REFERENCE
        //--------------
        //=1 | HOME BUTTON
        //=2 | RESERVE BUTTON
        //=3 | LIVEFLOOR BUTTON
        //=4 | SEARCH BUTTON
        
    
        
        //ASSESS BUTTON TAG
        switch sender.tag {
        case 1:
            didPressNavButtonHome()
        case 2:
            didPressNavButtonReserve()
        case 3:
            didPressNavButtonLiveFloor()
        case 4:
            didPressNavButtonSearch()
        default: break
        }
        
    }
    
    
    
    
    //--------------------------------------------
    // didPressNavButtonHome()
    //--------------------------------------------
    func didPressNavButtonHome(){
        
        //IF NOT AT HOME
        if homePositionState == false {
            //RETURN TO HOME
            toggleHomeScreen(goToHome: true)
        }
        toggleLiveFloorScreen(goToLiveFloorScreen: false)
        toggleReservationScreen(goToReservationScreen: false)
        toggleSearchScreen(goToSearchScreen: false)
        
    
        
        
    }
    
    
    
    //--------------------------------------------
    // didPressNavButtonReserve()
    //--------------------------------------------
    func didPressNavButtonReserve(){
        
        
        toggleHomeScreen(goToHome: false)
        toggleLiveFloorScreen(goToLiveFloorScreen: false)
        toggleSearchScreen(goToSearchScreen: false)
        toggleReservationScreen(goToReservationScreen: true)
        
        
        
        
        
    }
    
    
    
    
    //--------------------------------------------
    // didPressNavButtonLiveFloor()
    //--------------------------------------------
    func didPressNavButtonLiveFloor(){
        
        
        toggleHomeScreen(goToHome: false)
    
        toggleReservationScreen(goToReservationScreen: false)
        toggleSearchScreen(goToSearchScreen: false)
        toggleLiveFloorScreen(goToLiveFloorScreen: true)
        
        
        
        
    }
    
    
    
    
    //--------------------------------------------
    // didPressNavButtonSearch()
    //--------------------------------------------
    func didPressNavButtonSearch(){
        
        
        toggleHomeScreen(goToHome: false)
        toggleLiveFloorScreen(goToLiveFloorScreen: false)
        toggleReservationScreen(goToReservationScreen: false)
        toggleSearchScreen(goToSearchScreen: true)
        
        
        
    }
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- INTERFACE ANIMATIONS
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    //--------------------------------------------
    // toggleHomeScreen()
    //--------------------------------------------
    func toggleHomeScreen(goToHome:Bool) {
        
        //ASSESS GOTOHOME
        if goToHome == true{
            //ANIMATE TO HOME POSITION
        
            
            //ADJUST HOMEPANEL CONTRAINTS
            homePanelLeftConstraintAtHidden.isActive = false
            homePanelLeftConstraintAtVisible.isActive = true
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 1, delay: 1, options: [.curveEaseInOut], animations: {
                
                
                self.backgroundBlur.alpha = 0
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
            
        }
        else{
            //ANIMATE TO ACTION POSITION
            
            
            
            //ADJUST HOMEPANEL CONTRAINTS
            homePanelLeftConstraintAtVisible.isActive = false
            homePanelLeftConstraintAtHidden.isActive = true
            
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                
                
                self.backgroundBlur.alpha = 1
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
        }
        
        //SET CURRENT HOMEPOSITIONSTATE
        homePositionState = goToHome
        
        
        
    }
    
    
    
    
    
    
    
    //--------------------------------------------
    // toggleReservationScreen()
    //--------------------------------------------
    func toggleReservationScreen(goToReservationScreen:Bool) {
        
        //ASSESS
        if goToReservationScreen == true{
            //ANIMATE TO RESERVATION SCREEN
            
            
            
            
            //ADJUST CALENDAR CONSTRAINTS
            //ACTION PANEL WILL FOLLOW
            calendarContainerTopConstraintHidden.isActive = false
            calendarContainerTopConstraintVisible.isActive = true
            
           
            
            
            //ADJUST RESERVATION VIEWER CONSTRAINTS
            reservationViewerTrailingConstraintHidden.isActive = false
            reservationViewerTrailingConstraintVisible.isActive = true
            
    
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 1, delay: 0.8, options: [.curveEaseInOut], animations: {
                
                
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
           
            
            
            
        }
        else{
            //TOGGLE OFF RESERVATION SCREEN
           
            
            
            
            //ADJUST CALENDAR CONSTRAINTS
            //ACTION PANEL WILL FOLLOW
            calendarContainerTopConstraintVisible.isActive = false
            calendarContainerTopConstraintHidden.isActive = true
            
            
            
            
            
            //ADJUST RESERVATION VIEWER CONSTRAINTS
            reservationViewerTrailingConstraintVisible.isActive = false
            reservationViewerTrailingConstraintHidden.isActive = true
            
            
            //reservationViewerHeightConstraintHidden.isActive = true
            
            
            
            
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                
                
                
                
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                

                
            })
          
            
        }
        
    
        
    }

    
    
    
    
    
    
    
    //--------------------------------------------
    // toggleLiveFloorScreen()
    //--------------------------------------------
    func toggleLiveFloorScreen(goToLiveFloorScreen:Bool) {
        
        
        //ASSESS
        if goToLiveFloorScreen == true{
            //ANIMATE TO LIVE FLOOR SCREEN
            
            
            
            //ADJUST CONSTRAINTS
            liveFloorBottomConstraintHidden.isActive = false
            liveFloorCenterYConstraintVisible.isActive = true
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 1, delay: 0.8, options: [.curveEaseInOut], animations: {
            
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
            
            
        }
        else{
            //TOGGLE OFF LIVEFLOOR SCREEN
            
            //ADJUST CONSTRAINTS
            liveFloorCenterYConstraintVisible.isActive = false
            liveFloorBottomConstraintHidden.isActive = true
            
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // toggleSearchScreen()
    //--------------------------------------------
    func toggleSearchScreen(goToSearchScreen:Bool) {
        
        
        //ASSESS
        if goToSearchScreen == true{
            //ANIMATE TO LIVE FLOOR SCREEN
            
            
            
            //ADJUST CONSTRAINTS
            searchPanelTopConstraintHidden.isActive = false
            searchPanelCenterYConstraintVisible.isActive = true
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 1, delay: 0.8, options: [.curveEaseInOut], animations: {
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
            
            
        }
        else{
            //TOGGLE OFF LIVEFLOOR SCREEN
            
            //ADJUST CONSTRAINTS
            searchPanelCenterYConstraintVisible.isActive = false
            searchPanelTopConstraintHidden.isActive = true
            
            
            
            
            //ANIMATE NEW CONSTRAINTS
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
                
                //LAYOUT CONSTRAINTS
                self.view.layoutIfNeeded()
                
            }, completion: { _ in
                //COMPLETE
                
                
            })
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // didToggleCalendarMonth()
    //--------------------------------------------
    @IBAction func didToggleCalendarMonth(_ sender: UIButton) {
        
        //-------------
        //TAG REFERENCE
        //-------------
        //=1 | BACK
        //=2 | FORWARD
        
        
        
        
        //ASSESS DIRECTION
        if sender.tag == 1{
            //MOVE CALENDAR BACK A MONTH
            
            if monthSelectionIndex==0 {
                //CURRENTLY AT JAN, GO BACK TO DEC
                monthSelectionIndex = 11
            }
            else{
                monthSelectionIndex! -= 1
            }
            
        }
        else{
            //MOVE CALENDAR FORWARD A MONTH
            
            if monthSelectionIndex == 11{
                
                monthSelectionIndex = 0
                
            }
            else{
                monthSelectionIndex! += 1
            }
            
            
            
        }
        
        
        
        //UPDATE THE DISPLAY MONTH
        updateDateSelectionDisplay()
        
        
        //UPDATE CALENDAR DATA
        rebootCalenderData()
        
        
        //RELOAD CALENDAR
        calendarCollectionView.reloadData()
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // didPressSelectDateButton()
    //--------------------------------------------
    @IBAction func didPressSelectDateButton(_ sender: Any) {
        
        //RELOAD CALENDAR
        calendarCollectionView.reloadData()
        
        
        
        //SHOW CALENDAR
        calendarHeightConstraint.constant = 350
        
        
        //BRING IN MONTH SELECTOR
        calendarMonthSelectorPanelTrailingConstraintAtHidden.isActive = false
        calendarMonthSelectorPanelCenterXConstraintAtVisible.isActive = true
        
        
        
        //HIDE CURRENT MONTH SELECTOR
        selectedDateViewerCenterYConstraintVisible.isActive = false
        selectedDateViewerBottomConstraintHidden.isActive = true
        
        
        UIView .animate(withDuration: 0.5) {
        self.view.layoutIfNeeded()
        }
        
    
    
    }

    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- CALENDAR MANAGEMENT
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------

    //CELL IDENTIFIER
    let reuseIdentifier = "cell"
    
    //DECLARE LABEL ARRAY FOR CALENDAR
    var calendarDays : [Int] = []
    
    
    //--------------------------------------------
    // prepCalendarCollectionView()
    //--------------------------------------------
    func prepCalendarCollectionView(){
        
        
        
        
        
        
        
        //BUILD LABEL ARRAY FOR CALENDAR
        var i = 1
        repeat{
            
            calendarDays.append(i)
            
            i += 1
        }while i<38
        
        
        
        //BEGIN WITH TODAY
        applyTodaySelection()
        
        
        //REBOOT CALENDAR DATA
        rebootCalenderData()
        
        
        
        calendarCollectionView.backgroundColor = UIColor.clear
        
        //CALCULATE DIMENSIONS OF CALENDAR
        let cellWidth : CGFloat = calendarCollectionView.frame.size.width / 7.0
        let cellheight : CGFloat = calendarCollectionView.frame.size.height / 6.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        
        //CREATE LAYOUT AND SET TO CALENDAR
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        calendarCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    //--------------------------------------------
    // rebootCalenderData()
    //--------------------------------------------
    func rebootCalenderData(){
        
        
        
        
        let monthIndex = String(format: "%02d", (monthSelectionIndex!+1) )
        
        
        //HOW MANY DAYS IN THE CURRENT MONTH
        let dateComponents = DateComponents(year: 2017, month:(monthSelectionIndex!+1))
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        daysOfSelectedMonth = range.count
        
        
        
        
        
        
        //GET DAY OF WEEK OF FIRST DAY
        //SUN =1
        //MON =2
        //TUE =3
        //WED = 4
        //THU = 5
        //FRI = 6
        //SAT = 7
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: "2017-" + monthIndex + "-01")
        let myCalendar = Calendar(identifier: .gregorian)
        beginningWeekdayOfSelectedMonth = myCalendar.component(.weekday, from: todayDate!)
        
        
        
        
        
        
    }
    
    
    
    //--------------------------------------------
    // collectionView(_,numberOfItemsInSection)
    //--------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDays.count
    }
    
    
    
    //--------------------------------------------
    // collectionView(_,cellForItemAt)
    //--------------------------------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //DEQUEUE CELL, CAST AS FHCALENDARCOLLECTIONVIEWCELL
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! FHCalendarCollectioViewCell
        
        
        //CHECKER COLOR SCHEME OF CELLS
        if indexPath.item%2==0{
            cell.backgroundColor = UIColor.clear // make cell more visible in our example project
            
        }
        else{
            cell.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        }

        
        

        
        if indexPath.row < (beginningWeekdayOfSelectedMonth-1) {
            //TRIM OFF LEADING EXCESS DAYS
            
            cell.myLabel.text = ""
            cell.isUserInteractionEnabled = false
            
        }
        else{
            
            //ADJUST LABELS OF CELL
            let dayToDisplay = self.calendarDays[indexPath.item - (beginningWeekdayOfSelectedMonth-1)]
            if dayToDisplay > daysOfSelectedMonth {
                //TRIM TRAILING EXCESS DAYS
                
                cell.myLabel.text = ""
                cell.isUserInteractionEnabled = false
                
                
            }
            else{
                
                //SHOW AND ACTIVATE ONLY NEEDED CELLS
                cell.myLabel.text = "\(self.calendarDays[indexPath.item - (beginningWeekdayOfSelectedMonth-1)])"
                cell.myLabel.textColor = UIColor.white
                cell.isUserInteractionEnabled = true
                
                
                
                
                //ASSESS IF CELL IS SELECTED DATE
                //CONVERT INDICES TO STRINGS
                let daySelectionAsString = "\(calendarDays[indexPath.row - (beginningWeekdayOfSelectedMonth-1)])"
                let monthSelectionAsString = String(format:"%02d",monthSelectionIndex!+1)
                
                
                //CAPTURE DATE SELECTION
                let dateOfCell = monthSelectionAsString + "-" + daySelectionAsString + "-2017"
                
                
                if dateOfCell == dateSelection {
                    cell.backgroundColor = .green
                    cell.myLabel.textColor = .black
                    
                }

                
                
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    //--------------------------------------------
    // collectionView(_, didSelectItemAt)
    //--------------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        //CONVERT INDICES TO STRINGS
        let daySelectionAsString = "\(calendarDays[indexPath.row - (beginningWeekdayOfSelectedMonth-1)])"
        let monthSelectionAsString = String(format:"%02d",monthSelectionIndex!+1)
        
        
        //CAPTURE DATE SELECTION
        dateSelection = monthSelectionAsString + "-" + daySelectionAsString + "-2017"
        
        
        
        
        currentlySelectedMonthLabel.text = monthLabels[monthSelectionIndex!]
        currentlySelectedDayLabel.text = daySelectionAsString
        
        //HANDLE DATE SELECTION
        didSelectDate()
    
    
    }
    
    
    
        
        
    
    //--------------------------------------------
    // didSelectToday(_, didSelectItemAt)
    //--------------------------------------------
    @IBAction func didSelectToday(_ sender: Any) {
        
        //APPLY TODAY
        applyTodaySelection()
        
        
    }
    
    
    
    
    
    //--------------------------------------------
    // applyTodaySelection()
    //--------------------------------------------
    func applyTodaySelection(){
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = formatOfDate
        let result = formatter.string(from: date)
        
        
        //CAPTURE COMPLETE DATE SELECTION
        dateSelection = result
        
        
        
        //CAPTURE MONTH INDEX FROM SELECTION
        formatter.dateFormat = "MM"
        let monthIndex = formatter.string(from: date)
        monthSelectionIndex = Int(monthIndex)!-1
        
        
        formatter.dateFormat = "dd"
        let dayLabelForCurrentSelection = formatter.string(from: date)
        currentlySelectedDayLabel.text = dayLabelForCurrentSelection

        
        rebootCalenderData ()
        updateDateSelectionDisplay()
        didSelectDate()
        
        
    }
    
    
    
    
    
    //--------------------------------------------
    // didSelectDate()
    //--------------------------------------------
    func didSelectDate(){
        
        
        
        
        
        
        
        
        //RELOAD THE TABLE, USING NEW DATE
        reservationViewerTableView.reloadData()
        
        
        //HIDE CALENDAR
        calendarHeightConstraint.constant = 80
        
        //HIDE MONTH SELECTOR
        calendarMonthSelectorPanelCenterXConstraintAtVisible.isActive = false
        calendarMonthSelectorPanelTrailingConstraintAtHidden.isActive = true
        
        //SHOW CURRENT MONTH SELECTOR
        selectedDateViewerBottomConstraintHidden.isActive = false
        selectedDateViewerCenterYConstraintVisible.isActive = true
        
        
        UIView .animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // updateDateSelectionDisplay()
    //--------------------------------------------
    func updateDateSelectionDisplay(){
        
        
        
        monthSelectorLabel.text = monthLabels[monthSelectionIndex!]
        
        currentlySelectedMonthLabel.text = monthLabels[monthSelectionIndex!]
        
        
        
        

     
        
    }
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- SIZE PICKER MANAGEMENT
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    //BUILD LABEL ARRAY FOR CALENDAR
    var tableSizes : [Int] = []
    
    
    
    func preparePartySizeData(){
        
        var x = 1
        repeat {
            
            tableSizes.append(x)
            
            x += 1
            
        }while x<50
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        //
        
        return 40
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //
        
        return tableSizes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        //
        
        return 30
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        currentReservationBeingEdited?.reservationSize = tableSizes[row]
        
        reservationViewerTableView.reloadData()
        
        //SAVE DATA
        FHDataController.sharedInstance.saveMasterArray()
        
    }
    
    
    
    
    

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = beigeTone
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 25)
        
        label.text = "\(tableSizes[row])"
        
        return label
    }

    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- CLOCK MANAGEMENT
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    
    
    //--------------------------------------------
    // prepClock()
    //--------------------------------------------
    func prepClock(){
        
        
       
        
        
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    
    
    
    
    
    //--------------------------------------------
    // updateClock()
    //--------------------------------------------
    func updateClock(){
        
        //UPDATE DATE
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let result = formatter.string(from: date)
        currentDateLabel.text = result
        
        formatter.dateFormat  = "a"
        let amPm = formatter.string(from: date)
        
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if hour>12{
            hour -= 12
        }
        
        let hoursAsString = String(format: "%02d", hour)
        
        currentHourLabel.text = hoursAsString
        
        let minutesAsString = String(format: "%02d", minutes)
        currentMinuteLabel.text = minutesAsString
        
        
        amPmLabel.text = amPm
        
        
    }
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- MISC
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    //--------------------------------------------
    // didReceiveMemoryWarning
    //--------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    

}

