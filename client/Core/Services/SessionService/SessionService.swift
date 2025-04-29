//
//  SessionService.swift
//  Perspectives
//
//  Created by Ritesh Pakala Rao on 4/28/25.
//  
//

import Granite
import SwiftUI

struct SessionService: GraniteService {
    @Service(.online) var center: Center
}
