//
//  CarModel.swift
//  JPFanAppClient
//
//  Created by Christoph Pageler on 17.08.18.
//


import Foundation
import Quack


public extension JPFanAppClient {

    public class CarModel: Quack.Model {

        public enum TransmissionType: Int, Codable {

            case manual
            case automatic

        }

        public enum AxleType: Int, Codable {

            case all
            case front
            case rear

        }

        let id: Int?
        var name: String
        var manufacturerID: Int
        var transmissionType: TransmissionType
        var axleType: AxleType
        var mainImageID: Int?

        public required init?(json: JSON) {
            guard let id = json["id"].int,
                let name = json["name"].string,
                let manufacturerID = json["manufacturerID"].int,
                let transmissionTypeInt = json["transmissionType"].int,
                let transmissionType = TransmissionType(rawValue: transmissionTypeInt),
                let axleTypeInt = json["axleType"].int,
                let axleType = AxleType(rawValue: axleTypeInt)
            else {
                return nil
            }

            self.id = id
            self.name = name
            self.manufacturerID = manufacturerID
            self.transmissionType = transmissionType
            self.axleType = axleType
            self.mainImageID = json["mainImageID"].int
        }

        public init(name: String,
                    manufacturerID: Int,
                    transmissionType: TransmissionType,
                    axleType: AxleType,
                    mainImageID: Int?) {
            self.id = nil
            self.name = name
            self.manufacturerID = manufacturerID
            self.transmissionType = transmissionType
            self.axleType = axleType
            self.mainImageID = mainImageID
        }

    }

}
