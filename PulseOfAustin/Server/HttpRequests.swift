//
//  HttpRequests.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/23/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation
import Alamofire

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
    
    static func fetchExploreTopics(callback: @escaping ([ExploreTopic]) -> ()) {
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
                callback(exploreTopics)
            }
        }
    }
    
    static func fetchTopicData(topicKey: String, completion: @escaping (TopicData) -> ()) {
        dbRef?.child("topicData").child(topicKey).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary
                , let title = value["title"] as? String
                , let learnLabel = value["learnLabel"] as? String
                , let mapLabel = value["mapLabel"] as? String
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
                                          learnLabel: learnLabel,
                                          mapLabel: mapLabel,
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
            guard let values = snapshot.value as? [String: Any] else {return}
            completion(values)
        })
    }
    
    static func saveWeighInResponse(topicKey: String, answer: AnswerIndex, elaborateResponse: String?, completion: @escaping () -> ()) {
        let responsesPath = "weighIn/\(topicKey)/answerChoiceCounts/\(answer)"
        let elaboratePath = "weighIn/\(topicKey)/elaborateResponses/\(answer.elaborateKey())"
        
        dbRef?.child(responsesPath).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSInteger {
                self.dbRef?.child(responsesPath).setValue(value + 1)
            } else {
                self.dbRef?.child(responsesPath).setValue(1)
            }
            if !(elaborateResponse ?? "").isEmpty {
                self.dbRef?.child(elaboratePath).childByAutoId().setValue(elaborateResponse)
            }
            completion()
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
