//
//  AppViewModel.swift
//  GoWhere
//
//  Created by Hang Vu on 13/10/2024.

import Foundation
import MapKit
import SwiftUI

class AppViewModel: ObservableObject{
    @Published var userFavList: [String] = [];
    
    //  MAP KIT Properties
    @Published var mapCameraPosition: MapCameraPosition
    let defaultCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    init(){
        
        //  INIT MAP View Properties
        self.defaultCoordinates = CLLocationCoordinate2D(latitude: 16.16666666, longitude: 107.83333333)
        self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: defaultCoordinates, distance: 10000000))
        
        //  DEBUG
//        print(self.userFavList);
    }
}


