//
//  AppEnvironment.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 18/05/25.
//

import Foundation
import Common

struct AppEnvironment: AppEnvironmentProviding {
    var apiKey: String { AppConfigMain.API_KEY }
    var email: String { AppConfigMain.EMAIL }
    var gitLink: String { AppConfigMain.GIT_LINK }
    var website: String { AppConfigMain.MY_WEBSITE }
}
