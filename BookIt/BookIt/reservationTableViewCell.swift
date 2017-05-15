//
//  reservationTableViewCell.swift
//  BookIt
//
//  Created by Fawzi Hindi on 5/14/17.
//  Copyright © 2017 ARENV. All rights reserved.
//

import UIKit

//--------------------------------------------
//--------------------------------------------
// MARK:- PROTOCOL
// MARK:-
//--------------------------------------------
//--------------------------------------------
protocol reservationTableViewCellDelegate {
    
    func didSelectReservation(cell : reservationTableViewCell, interval: Int)
    func didCreateReservation(cell : reservationTableViewCell, interval: Int)
    func overbookingWarning()
    
    func clearReservationEditor()
    
    
}










//--------------------------------------------
//--------------------------------------------
// MARK:- IMPLEMENTATION
// MARK:-
//--------------------------------------------
//--------------------------------------------

class reservationTableViewCell: UITableViewCell {
    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- PROPERTIES
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    var delegate : reservationTableViewCellDelegate?
    
    //USED TO ADJUST LABELS ACCORDING TO TABLENAME
    var arrayOfTableLabels : [UILabel] = []
    
    //USED TO PREVENT OVERBOOKING
    var arrayOfTimeMarks : [Int] = []
    
    
    var arrayOfReservationLabels : [UILabel] = []
    
    
    
    var arrayOfReservations : [reservationObject] = []
    
    
    
    let reservationWaitingColor = UIColor.init(red: 1, green: 1, blue: 0.2, alpha: 1)
    let reservationFulfilledColor = UIColor.init(red: 0, green: 1, blue: 0.2, alpha: 1)
    
    
    
    
    
    
    
    
    //--------------------------------------------
    //--------------------------------------------
    // MARK:- INITIALIZATION
    // MARK:-
    //--------------------------------------------
    //--------------------------------------------
    
    
    //--------------------------------------------
    // awakeFromNib()
    //--------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
        
        //FIRST OF TWO LONG PRESS GESTURE RECOGNIZERS
        //ADDED TO MAIN CONTENTVIEW, RESULTS IN ADDITION
        //OF NEW RESERVATION
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gestureRecognizer:)))
        tapGesture.minimumPressDuration = 0.5
        addGestureRecognizer(tapGesture)

        
        
        
        
        
        
        //CREATE TABLELABELS ACROSS EACH CELL
        var i = 0
        repeat {
            
            //CREATE LABEL
            let iterateLabel = UILabel(frame: CGRect(x: i*100, y: 0, width: 100, height: Int(self.frame.size.height)))
            
            //CUSTOMIZE LABEL
            iterateLabel.textAlignment = .center
            iterateLabel.backgroundColor = .clear
            iterateLabel.textColor = UIColor(red: 0.3, green: 0, blue: 0, alpha: 0.4)
            iterateLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: 20)
            
            
            //STORE LABEL IN ARRAY | USED TO ACCESS LABELS 
            //TO CHANGE LABEL ACCORDING TO CURRENT ROW
            arrayOfTableLabels.append(iterateLabel)
            
            //ADD LABEL TO VIEW
            self.addSubview(iterateLabel)
            
            i += 1
            
            
        } while i <= 33
        
    }

    
    
    
    
    //--------------------------------------------
    // setSelected( ,animated)
    //--------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // longPressAction()
    //--------------------------------------------
    func longPressAction(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began{

            
            //---------
            //REFERENCE
            //---------
            //EACH HOUR IS 200 POINTS
            //EACH RESERVATION TIME IS 1/4*200=50 POINTS AS RESERVATIONS
            //ARE MADE IN INCREMENTS OF 15 MINUTES (1/4 HOUR)
            
            
            
            //GRAB LOCATION OF GESTURE RECOGNIZER, RETRIEVE THE X COORDINATE,
            //AND CONVERT TO RATIO OF TIME INTERVAL
            let location = gestureRecognizer.location(in: self)
            let xCoordinate = location.x
            let ratio = floor(xCoordinate/50)
            let interval = Int(ratio)
            
            
            //NOTE: IF A RESERVATION IS CREATED, IT WILL BE GIVEN A LONGPRESS
            //RECOGNIZER, AND THUS USER CANNOT BOOK RESERVATION ON TOP OF CURRENT
            //LABEL.  HERE, HOWEVER, BOOKING TOO CLOSE BEFORE ANY CURRENT 
            //RESERVATIONS IS PREVENTED.  FOR EXAMPLE, IF RESERVATION IS CURRENTLY
            //MADE FOR 9AM, THE FOLLOWING CODE WILL PREVENT BOOKINGS AFTER 8:15AM
            //AS THIS WILL LEAD TO OVERBOOKING
            if arrayOfTimeMarks.contains(interval+1)||arrayOfTimeMarks.contains(interval+2){
                //-------------
                //OVERBOOKING
                //-------------
                
                delegate?.overbookingWarning()
                
                
                
                
            }else{
                //-------------
                //CLEAR TO BOOK
                //-------------
                
                
                //CREATE AND CUSTOMIZE LABEL
                let iterateLabel = UILabel(frame: CGRect(x: (interval*50)+2, y: 5, width: 148, height: Int(self.frame.size.height - 10)))
                iterateLabel.textAlignment = .left
                iterateLabel.backgroundColor = reservationWaitingColor
                iterateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                iterateLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: 14)
                iterateLabel.text = " Guest(2)"
                iterateLabel.layer.cornerRadius = 5
                iterateLabel.layer.masksToBounds = true
                
                //SECOND OF TWO MAIN SELECTION RECOGNIZERS
                //SET RECOGNIZER TO LABEL
                let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapFunction(gestureRecognizer:)))
                iterateLabel.isUserInteractionEnabled = true
                tap.minimumPressDuration = 0.01
                iterateLabel.addGestureRecognizer(tap)
                
                //TAG THE LABEL TO COORDINATE SELECTIONS
                iterateLabel.tag = interval
                
                
                //ADD LABEL TO VIEW
                self.addSubview(iterateLabel)
                
                
                //UPDATE TRACKING DATA
                arrayOfTimeMarks.append(interval)
                arrayOfReservationLabels.append(iterateLabel)
                
                
                //INFORM DELEGATE OF NEW RESERVATION
                delegate?.didCreateReservation(cell: self, interval: interval)
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    //--------------------------------------------
    // gestureRecognizer( ,shouldReceive)
    //--------------------------------------------
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.contentView{
            
            return false
        }
        
        delegate?.clearReservationEditor()
        return true
       
    }
    
   
    
    
    //--------------------------------------------
    // gestureRecognizer( ,shouldRecognizeSimultaneouslyWith)
    //--------------------------------------------
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    
    
    
    //--------------------------------------------
    // tapFunction()
    //--------------------------------------------
    func tapFunction(gestureRecognizer:UITapGestureRecognizer) {
        
        //REFERENCE | SECOND OF TWO MAIN SELECTION GESTURE 
        //RECOGNIZER.  FIRST RECOGNIZER CREATES RESERVATION,
        //THIS RECOGNIZER SELECTS THE LABEL
        
        
        
        delegate?.didSelectReservation(cell: self, interval: (gestureRecognizer.view?.tag)!)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // clearReservationLabelsFromCell()
    //--------------------------------------------
    func clearReservationLabelsFromCell(){
        
        for iterateLabel in arrayOfReservationLabels {
            
            iterateLabel.removeFromSuperview()
        }
        
        arrayOfReservationLabels = []
        arrayOfTimeMarks = []
        
        
    }
    
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // updateTableLabels()
    //--------------------------------------------
    func updateTableLabels(tableNumber: Int) {
        
        
        for iterateLabel in arrayOfTableLabels {
            
            iterateLabel.text = "\(tableNumber)"
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    //--------------------------------------------
    // buildRowWithTodayReservations()
    //--------------------------------------------
    func buildRowWithTodayReservations() {
        
        
        
        if arrayOfReservations.count > 0{
            //IF THERE ARE ANY RESERVATIONS
        
        
            for iterateReservation in arrayOfReservations{
                
                
                let interval = iterateReservation.reservationTimeInterval
                
                
                
                
                
                //CREATE AND CUSTOMIZE LABEL
                let iterateLabel = UILabel(frame: CGRect(x: (interval!*50)+2, y: 5, width: 148, height: Int(self.frame.size.height - 10)))
                iterateLabel.textAlignment = .left
                
                //CHECK IF FULFILLED
                if iterateReservation.reservationIsFulfilled == false{
                    iterateLabel.backgroundColor = reservationWaitingColor

                }
                else{
                    iterateLabel.backgroundColor = reservationFulfilledColor

                }
                iterateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                iterateLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: 14)
                iterateLabel.layer.cornerRadius = 5
                iterateLabel.layer.masksToBounds = true
                
                
                //SET NAME AND PARTY SIZE
                let partyName = iterateReservation.reservationName
                let partySize = iterateReservation.reservationSize!
                iterateLabel.text = " "+partyName!+"(\(partySize))"
                
                
                
                
                
                
                //SECOND OF TWO MAIN SELECTION RECOGNIZERS
                //SET RECOGNIZER TO LABEL
                let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapFunction(gestureRecognizer:)))
                iterateLabel.isUserInteractionEnabled = true
                tap.minimumPressDuration = 0.01
                iterateLabel.addGestureRecognizer(tap)
                
                //TAG THE LABEL TO COORDINATE SELECTIONS
                iterateLabel.tag = interval!
                
                
                //ADD LABEL TO VIEW
                self.addSubview(iterateLabel)
                
                
                //UPDATE TRACKING DATA
                arrayOfTimeMarks.append(interval!)
                arrayOfReservationLabels.append(iterateLabel)
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}






