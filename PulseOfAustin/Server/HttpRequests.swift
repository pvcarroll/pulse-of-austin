//
//  HttpRequests.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class HTTPRequests {
    
    private static let dbRef = (UIApplication.shared.delegate as! AppDelegate).dbRef
    
    static func getCouncilDistrict(address: String, completion: @escaping (Int) -> ()) {
        let addressToDistrictURL = "https://www.austintexas.gov/gis/rest/Geocode/COA_Address_Locator/GeocodeServer/findAddressCandidates"
        let streetParam = address.replacingOccurrences(of: " ", with: "+")
        let url = "\(addressToDistrictURL)?street=\(streetParam)&outFields=*&f=pjson"
        Alamofire.request(url).responseJSON(completionHandler: { response in
            if let json = response.result.value as? NSDictionary
                , let candidates = json["candidates"] as? NSArray?
                , let count = candidates?.count
                , count > 0
                , let firstCandidate = candidates?[0] as? NSDictionary {
                if let attributes = firstCandidate["attributes"] as? NSDictionary {
                    if let councilDistrictString = attributes["CouncilDistrict"] as? String, let councilDistrict = Int(councilDistrictString) {
                        completion(councilDistrict)
                    }
                }
            } else {
                completion(0)
            }
        })
    }
    
    //
    // MARK:- Firebase Database
    //
    
    static func saveNewUser(uid: String, userData: [String : Any], completion: @escaping () -> ()) {
        dbRef?.child(AppConstants.dbUsersPath).child(uid).setValue(userData)
        completion()
    }
    
    static func saveUserInfo(userID: String, address: String, email: String, zipCode: String, councilDistrict: Int?, completion: @escaping (_ error: Error?) -> ()) {
        if let councilDistrict = councilDistrict {
            dbRef?.child(AppConstants.dbUsersPath).child(userID).updateChildValues([
                "address": address,
                "councilDistrict": councilDistrict,
                "zipCode": zipCode,
                "email": email
                ], withCompletionBlock: { (error, ref) in
                    completion(error)
            })
        } else {
            dbRef?.child(AppConstants.dbUsersPath).child(userID).updateChildValues([
                "address": address,
                "zipCode": zipCode,
                "email": email
                ], withCompletionBlock: { (error, ref) in
                    completion(error)
            })
        }
    }
    
    static func fetchExploreTopics(completion: @escaping ([ExploreTopic]) -> ()) {
        dbRef?.child("exploreTopics").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                var exploreTopics = [ExploreTopic]()
                value.allKeys.forEach({ (key) in
                    if let topicKey = key as? String
                        , let exploreTopicData = value[key] as? NSDictionary {
                        let exploreTopic = ExploreTopic.convertDataToExploreTopic(topicKey: topicKey,
                                                                                  exploreTopicData: exploreTopicData)
                        exploreTopics.append(exploreTopic)
                    }
                })
                completion(exploreTopics)
            }
        }
    }
    
    static func fetchTopicData(topicKey: String, completion: @escaping (TopicData) -> ()) {
        dbRef?.child("topicData").child(topicKey).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary
                , let title = value["title"] as? String
                , let readUpLabel = value["readUpLabel"] as? String
                , let visualizeLabel = value["visualizeLabel"] as? String
                , let viewpointsLabel = value["viewpointsLabel"] as? String
                , let milestonesLabel = value["milestonesLabel"] as? String
                , let dateUpdated = value["dateUpdated"] as? String
                , let weighInPrompt = value["weighInPrompt"] as? String
                , let choicesDictionary = value["weighInChoices"] as? NSDictionary
                , let choiceKeys = choicesDictionary.allKeys as? [String] {
                var weighInChoices = [String]()
                let sortedChoiceKeys = choiceKeys.sorted {  $0 < $1 }
                sortedChoiceKeys.forEach({ (key) in
                    weighInChoices.append(choicesDictionary[key] as! String)
                })
                var infoSlides = [String]()
                if let infoSlidesDict = value["infoSlides"] as? NSDictionary
                    , let infoSlideKeys = infoSlidesDict.allKeys as? [String] {
                    infoSlideKeys.sorted(by: { $0 < $1 }).forEach({ (slide) in
                        if let slideString = infoSlidesDict[slide] as? String {
                            infoSlides.append(slideString)
                        }
                    })
                }
                
                let topicData = TopicData(topicKey: topicKey,
                                          title: title,
                                          readUpLabel: readUpLabel,
                                          visualizeLabel: visualizeLabel,
                                          viewpointsLabel: viewpointsLabel,
                                          milestonesLabel: milestonesLabel,
                                          dateUpdated: dateUpdated,
                                          infoSlides: infoSlides,
                                          weighInPrompt: weighInPrompt,
                                          weighInChoices: weighInChoices)
                completion(topicData)
            }
        })
    }
    
    static func getWeighInResponses(topicKey: String, completion: @escaping ([String : Any]) -> ()) {
        let answerCountsPath = "weighIn/\(topicKey)/answerChoiceCounts"
        dbRef?.child(answerCountsPath).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let values = snapshot.value as? [String: Any] else { return }
            completion(values)
        })
    }
    
    static func getViewPointsForTopic(topicKey: String, completion: @escaping ([Viewpoint]) -> ()) {
        let viewpointsPath = "weighIn/\(topicKey)/elaborateResponses"
        dbRef?.child(viewpointsPath).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let elaborateResponsesData = snapshot.value as? [String: Any] else { return }
            var viewpoints = [Viewpoint]()
            elaborateResponsesData.values.forEach({ (elaborateResponseData) in
                if let data = elaborateResponseData as? [String : Any]
                    , let viewpointData = data.values.first as? [String : Any]
                    , let text = viewpointData["text"] as? String
                    , let latitude = viewpointData["latitude"] as? Double
                    , let longitude = viewpointData["longitude"] as? Double
                    , let date = viewpointData["date"] as? String {
                        let elaborateResponse = Viewpoint(text: text, latitude: latitude, longitude: longitude, date: date)
                        viewpoints.append(elaborateResponse)
                }
            })
            completion(viewpoints)
        })
    }
    
    static func checkIfTopicAnswered(userID: String, topicKey: String, completion: @escaping (Bool) -> ()) {
        dbRef?.child(AppConstants.dbUsersPath).child(userID)
            .child(AppConstants.dbTopicsAnswered).child(topicKey)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                guard let answered = snapshot.value as? Bool else {
                    completion(false)
                    return
                }
                completion(true)
            })
    }
    
    static func saveWeighInResponse(uid: String, topicKey: String, answer: AnswerIndex,
                                    elaborateResponse: Viewpoint?, completion: @escaping () -> ()) {
        let responsesPath = "weighIn/\(topicKey)/answerChoiceCounts/\(answer)"
        let elaboratePath = "weighIn/\(topicKey)/elaborateResponses/\(answer.elaborateKey())"
        
        dbRef?.child(responsesPath).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSInteger {
                self.dbRef?.child(responsesPath).setValue(value + 1)
            } else {
                self.dbRef?.child(responsesPath).setValue(1)
            }
            if (elaborateResponse != nil) && (elaborateResponse?.text != "") {
                // Get user's address
                dbRef?.child(AppConstants.dbUsersPath).child(uid).child(AppConstants.address)
                    .observeSingleEvent(of: .value, with: { (snapshot) in
                        if let address = snapshot.value as? String {
                            let geoCode = CLGeocoder()
                            // Convert user's address to latitude, longitude
                            geoCode.geocodeAddressString(address) { (placemarks, error) in
                                if let coordinate = placemarks?[0].location?.coordinate {
                                    let latitude = coordinate.latitude
                                    let longitude = coordinate.longitude
                                    let elaborateReponseDictionary = ["text": elaborateResponse?.text,
                                                                      "latitude": latitude,
                                                                      "longitude": longitude,
                                                                      "date": elaborateResponse?.date] as [String : Any]
                                    self.dbRef?.child(elaboratePath).childByAutoId().setValue(elaborateReponseDictionary)
                                }
                            }
                        }
                    }, withCancel: { (error) in
                        // TODO: save response without lat/long
                    })
            }
            dbRef?.child(AppConstants.dbUsersPath)
                .child(uid)
                .child(AppConstants.dbTopicsAnswered)
                .child(topicKey)
                .setValue(1)
            completion()
        })
    }
    
    static func getUserName(uid: String, completion: @escaping (String) -> ()) {
        dbRef?.child(AppConstants.dbUsersPath).child(uid).child(AppConstants.name)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? String {
                    completion(value)
                }
            })
    }
    
    static func getUserInfo(uid: String, completion: @escaping ([String: Any]) -> ()) {
        dbRef?.child(AppConstants.dbUsersPath).child(uid)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                if let values = snapshot.value as? [String: Any] {
                    completion(values)
                }
            })
    }
}
