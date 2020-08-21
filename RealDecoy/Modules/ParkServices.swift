//
//  ParkServices.swift
//  RealDecoy
//
//  Created by CanAssist  on 2020-08-20.
//  Copyright © 2020 adebayo. All rights reserved.
//

import UIKit
var APIkEY = "zkqXzFBUJ1ie1lfSgBg50GqV6LpAkLphl4swylBP"
struct Activities: Decodable {
      let total: String
      let data : [data]
      //    let userId: Int
      //    let title: String
      //    let completed: Bool
      //
      struct data : Decodable {
          let designation: String
          let description : String
          let id : String
          let contacts : contacts
          let addresses : [addresses] //description:Park addresses (physical and mailing)
          let fullName : String
          let latitude : String
          let longitude : String
          let name : String
          let states : String //State(s) the park is located in (comma-delimited list)
          let images : [images] //Park images
          let url : String // parking website
        let activities : [activities]
        let operatingHours : [operatingHours]
      }
    struct operatingHours  : Decodable{
        let standardHours : standardHours
    }
    struct  standardHours : Decodable {
        let monday : String
        let tuesday : String
        let wednesday : String
        let thursday : String
        let friday : String
        let saturday :  String
        let sunday : String
    }
    struct activities : Decodable {
        let id : String
        let name : String
    }
      struct addresses: Decodable {
          let postalCode : String
          let city : String
          let stateCode : String
          let line1 : String
          let line3 : String
          let line2 : String
      }
    
      struct contacts : Decodable {
          let phoneNumbers : [phoneNumbers]
          let emailAddresses : [emailAddresses]
      }
      struct phoneNumbers: Decodable {
          let phoneNumber : String
          let description : String
          let `extension` : String
          let type : String
      }
      struct  emailAddresses: Decodable {
          let emailAddress : String
          let description : String
      }
      struct images : Decodable {
          let url : String
          let credit : String
          let title : String
          let caption : String
      }
}
class datavalue {
    static let share = datavalue()
    var  parkdetails : Activities? = nil
}
      
class ParkServices {
    
    //APPError enum which shows all possible errors
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    //Result enum to show success or failure
    enum Result<T> {
        case success(T)
        case failure(APPError)
    }
    
    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        //create the url with NSURL
        let dataURL = URL(string: url)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(Result.failure(APPError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(APPError.dataNotFound))
                return
            }
            
            do {
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
  
    func getRequestWithStateCode(statecode : String , oncompletion : @escaping(Activities) -> Void){
            let newParkRequest = parkRequest(statecode: statecode)
            print(newParkRequest.RequestWithStateCode!)
            ParkServices.init().dataRequest(with: newParkRequest.RequestWithStateCode!, objectType: Activities.self) { (result: Result) in
                switch result {
                    case .success(let object):
                        dump(object)
                        datavalue.share.parkdetails = object
                        oncompletion(object)
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
    struct parkRequest {
        let mainRequest = "parks?stateCode="
        var endPoint_first = "https://developer.nps.gov/api/v1/parks?stateCode="
        
        var endpoint_second = "&limit="
        var endpoint_last = "&api_key=zkqXzFBUJ1ie1lfSgBg50GqV6LpAkLphl4swylBP"
        let statecode : String?
        let limit : String? = "50"
        let startInteger : Int? = 0
        let searchTerm : String?
        let parkCode : [String]?
        init( statecode : String?, searchTerm : String? ,parkCode : [String]?  ) {
            self.statecode = statecode
            self.searchTerm = searchTerm
            self.parkCode = parkCode
        }
        
        init(statecode : String) {
            self.statecode  = statecode
            self.searchTerm = nil
            self.parkCode = nil
        }
        //sort out the statecode
        var RequestWithStateCode : String?{
            if let statecode = statecode {
                return endPoint_first + statecode + endpoint_second + limit! + endpoint_last
                
            }else{
                return ""
            }
        }
    }
 
    



public let statecode  : [String : String] = [
    "AL": "Alabama",
    "AK": "Alaska",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District Of Columbia",
    "FL": "Florida",
    "GA": "Georgia",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "NV": "Nevada",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PA": "Pennsylvania",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VT": "Vermont",
    "VA": "Virginia",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming"
]


