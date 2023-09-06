//
//  ViewController.swift
//  LocationSwitcher
//
//  Created by Andrea Stevanato on 26/11/20.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var installedAppsLabel: UILabel! {
        didSet {
            self.installedAppsLabel.text = getInstalledAppsText()
        }
    }

    let locationManager = CLLocationManager()

    // MARK: - View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        mapView.delegate = self

        locationManager.requestAlwaysAuthorization()
    }

    // MARK: - Map Actions

    @IBAction private func didTapOnUpdateMapButton(_ button: UIButton) {
        updateMapViewUserRegion()
        self.installedAppsLabel.text = getInstalledAppsText()
    }

    private func getInstalledAppsText() -> String {
    """
    DoveConviene installed: \(UIApplication.shared.canOpenURL(URL(string: "dvc://")!))
    CardPlus installed: \(UIApplication.shared.canOpenURL(URL(string: "cardplusapp://")!))
    PromoQui installed: \(UIApplication.shared.canOpenURL(URL(string: "promoquiapp://")!))
    VolantinoFacile installed: \(UIApplication.shared.canOpenURL(URL(string: "vfapp://")!))
    Tiendeo installed: \(UIApplication.shared.canOpenURL(URL(string: "tiendeo://")!))
    """
    }

    private func updateMapViewUserRegion() {
        if let userLocationCoordinate = self.locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocationCoordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            DispatchQueue.main.async {
                self.mapView.setRegion(viewRegion, animated: true)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}

