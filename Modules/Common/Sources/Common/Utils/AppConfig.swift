//
//  AppConfig.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 06/05/25.
//

import Foundation

public protocol AppEnvironmentProviding {
    var apiKey: String { get }
    var email: String { get }
    var gitLink: String { get }
    var website: String { get }
}

public enum AppConfig {
    public static var environment: AppEnvironmentProviding?
}
