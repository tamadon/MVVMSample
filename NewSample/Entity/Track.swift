//
//  Track.swift
//

import ObjectMapper

public struct Track: Mappable {
    
    var trackName = ""
    var trackId = ""
    var artistName = ""
    
    public init?(_ map: Map){}
    
    mutating public func mapping(map: Map) {
        trackId     <- map["trackId"]
        trackName   <- map["trackName"]
        artistName  <- map["artistName"]
    }
}
