//
//  GitHubAPI.swift
//  Zen
//
//  Created by Isaac Overacker on 4/15/16.
//
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

let GitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

public enum GitHub {
    case Zen
}

extension GitHub: TargetType {
    public var baseURL: NSURL { return NSURL(string: "https://api.github.com")! }
    public var path: String {
        switch self {
        case .Zen:
            return "/zen"
        }
    }
    public var method: Moya.Method {
        return .GET
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        default:
            return nil
        }
    }

    public var sampleData: NSData {
        switch self {
        case .Zen:
            return "Anything added dilutes everything else".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

public func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
