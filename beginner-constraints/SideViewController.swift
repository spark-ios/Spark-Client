//
//  SideViewController.swift
//  Beginner-Constraints
//
//  Created by amentech user on 23/01/2019.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit
import MapKit

class SideViewController: UIViewController {
    
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    let defaultValues = UserDefaults.standard
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUsername.text = name
        }else{
            print("di gumana")
        }
        let mainVC = UIViewController()
      
        
        let rootController = RootViewController(mainViewController: mainVC, topNavigationLeftImage: UIImage(named: "navi"))
        let menuVC = MenuViewController()
        menuVC.view.backgroundColor = .green
        
        let drawerVC = DrawerController(rootViewController: rootController, menuController: menuVC)
        
        self.addChild(drawerVC)
        view.addSubview(drawerVC.view)
        drawerVC.didMove(toParent: self)
        
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 14.5547, longitude: 121.0244)
        
        centerMapOnLocation(location: initialLocation)
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}
