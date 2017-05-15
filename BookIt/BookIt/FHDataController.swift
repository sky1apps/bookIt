//
//  FHDataController.swift
//  BookIt
//
//  Created by Fawzi Hindi on 5/14/17.
//  Copyright © 2017 ARENV. All rights reserved.
//

import UIKit


//--------------------------------------------
// FHDataController
//--------------------------------------------
final class FHDataController: NSObject, NSCoding {
   
    
    
    // MARK: SINGLETON OBJECT
    static let sharedInstance = FHDataController()
    
    
    //MASTER ARRAY
    var masterArray : [tableObject] = []
    
    
    
    
    //--------------------------------------------
    // init()
    //--------------------------------------------
    override private init() {
        super.init()
        
        
        
        print("INITIALIZING DEMO DATA")

        
        var i = 0
        repeat {

            let iterateTable :tableObject = tableObject.init(tableName: "\(100+i)")
            
            masterArray.append(iterateTable)
            
            i+=1
            
        } while i<20
        
        
        
    }
    
    
    
    
   
    
    //--------------------------------------------
    // accessMasterArray()
    //--------------------------------------------
    func accessMasterArray() -> Array<Any>{
        
        return self.masterArray
        
        
    }

    
    //--------------------------------------------
    // saveMasterArray()
    //--------------------------------------------
    func saveMasterArray() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: self.masterArray)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "masterArray")
    }
    
    
    
    
    
    //--------------------------------------------
    // loadMasterArray()
    //--------------------------------------------
    func loadMasterArray() {
        let defaults = UserDefaults.standard
        
        if let savedArray = defaults.object(forKey: "masterArray") as? Data {
            self.masterArray = NSKeyedUnarchiver.unarchiveObject(with: savedArray) as! [tableObject]
        
        
        }
        
        
    }
    
    
    
    
        
    
    //--------------------------------------------
    // NSCODING METHODS
    //--------------------------------------------
    required init(coder aDecoder: NSCoder) {
        masterArray = aDecoder.decodeObject(forKey: "masterArray") as! [tableObject]
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(masterArray, forKey: "masterArray")
    }
    
    

}









//--------------------------------------------
// tableObject
//--------------------------------------------
class tableObject : NSObject, NSCoding{
    
    
    var tableName : String
    
    var arrayOfReservations : [reservationObject]
    
    
    
    //--------------------------------------------
    // init()
    //--------------------------------------------
    init(tableName: String){
        
        self.tableName = tableName
        
        arrayOfReservations = []
        
    
    }
    
    
    
    //--------------------------------------------
    // NSCODING METHODS
    //--------------------------------------------
    required init(coder aDecoder: NSCoder) {
        tableName = aDecoder.decodeObject(forKey: "tableName") as! String
        arrayOfReservations = aDecoder.decodeObject(forKey: "arrayOfReservations") as! [reservationObject]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tableName, forKey: "tableName")
        aCoder.encode(arrayOfReservations, forKey: "arrayOfReservations")

    }
    
    
    
    
}





//--------------------------------------------
// reservationObject
//--------------------------------------------
class reservationObject : NSObject, NSCoding{
    
    var reservationName : String?
    var reservationSize : Int?
    var reservationDate : String?
    var reservationTable : String?
    var reservationTimeInterval : Int?
    var reservationIsFulfilled : Bool = false
    
    
    
    
    //--------------------------------------------
    // init()
    //--------------------------------------------
    init(name: String, size: Int, date: String, table: String, timeInterval: Int) {
    
        self.reservationName = name
        self.reservationSize = size
        self.reservationDate = date
        self.reservationTable = table
        self.reservationTimeInterval = timeInterval
        self.reservationIsFulfilled = false
        
        
    }
    
    
    
    
    //--------------------------------------------
    // toggleFulfilledStatus()
    //--------------------------------------------
    func toggleFulfilledStatus(){
        
        if reservationIsFulfilled == false {
            reservationIsFulfilled = true
        }
        else{
            reservationIsFulfilled = false
        }
        
                
    }
    
    
    
    
    
    //--------------------------------------------
    // NSCODING METHODS
    //--------------------------------------------
    required init(coder aDecoder: NSCoder) {
        reservationName = aDecoder.decodeObject(forKey: "reservationName") as? String ?? ""
        reservationSize = aDecoder.decodeObject(forKey: "reservationSize") as? Int ?? aDecoder.decodeInteger(forKey: "reservationSize")
        reservationDate = aDecoder.decodeObject(forKey: "reservationDate") as? String ?? ""
        reservationTable = aDecoder.decodeObject(forKey: "reservationTable") as? String ?? ""
        reservationTimeInterval = aDecoder.decodeObject(forKey: "reservationTimeInterval") as? Int ?? aDecoder.decodeInteger(forKey: "reservationTimeInterval")
        reservationIsFulfilled = aDecoder.decodeBool(forKey: "reservationIsFulfilled")
        
        
        
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(reservationName, forKey: "reservationName")
        aCoder.encode(reservationSize, forKey: "reservationSize")
        aCoder.encode(reservationDate, forKey: "reservationDate")
        aCoder.encode(reservationTable, forKey: "reservationTable")
        aCoder.encode(reservationTimeInterval, forKey: "reservationTimeInterval")
        aCoder.encode(reservationIsFulfilled, forKey: "reservationIsFulfilled")
        
    }
    
    
    
    
}








