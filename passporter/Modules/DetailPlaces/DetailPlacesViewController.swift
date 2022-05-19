//
//  DetailPlacesViewController.swift
//  passporter
//
//  Created by dgonzbal on 11/5/22.
//

import Foundation
import UIKit
import ImageSlideshow
import MapKit
import ImageSlideshowAlamofire

class DetailPlacesViewController: UIViewController {
    @IBOutlet weak var slideView: ImageSlideshow!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goToButton: UIButton!
    
    private var place: PlaceModel?
    
    
    override func viewDidLoad() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideView.addGestureRecognizer(gestureRecognizer)
        if let place = place {
            configure(place: place)
        }
    }
    
    func configure(place: PlaceModel) {
        setMapPoint(location: place.location, title: place.name)
        configureSlider()
    }
}

// MARK: slideView
extension DetailPlacesViewController {
    func configureSlider() {
        let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!,
                               AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!,
                               AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
        slideView.setImageInputs(alamofireSource)
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
        pageIndicator.pageIndicatorTintColor = UIColor.black
        slideView.pageIndicator = pageIndicator
    }
}

// MARK: Map
extension DetailPlacesViewController {
    func setMapPoint(location: Location?, title: String?) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude:location?.longitude ?? 0)
        annotation.coordinate = centerCoordinate
        annotation.title = title
        
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion( center: centerCoordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func setPlace(place: PlaceModel) {
        self.place = place
    }
}

// MARK: Actions
extension DetailPlacesViewController {
    @IBAction func goToMapApp() {
        let coordinate = CLLocationCoordinate2DMake(place?.location?.latitude ?? 0,place?.location?.longitude ?? 0)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = place?.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @objc func didTap() {
        slideView.presentFullScreenController(from: self)
    }
}
