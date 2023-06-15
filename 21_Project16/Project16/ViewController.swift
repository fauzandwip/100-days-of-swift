//
//  ViewController.swift
//  Project16
//
//  Created by Fauzan Dwi Prasetyo on 08/05/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(changeMapType))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        let jakarta = Capital(title: "Jakarta", coordinate: CLLocationCoordinate2D(latitude: -6.2, longitude: 106.816666), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington, jakarta])
        mapView.mapType = .standard
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }
        
        annotationView?.markerTintColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.capitalName = capital.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Choose Map Style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: mapType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: mapType))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: mapType))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func mapType(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        
        switch actionTitle {
        case "Standard":
            mapView.mapType = .standard
        case "Satellite":
            mapView.mapType = .satellite
        case "Hybrid":
            mapView.mapType = .hybrid
        default:
            print("Standard Map Style")
        }
        
    }
    
}

