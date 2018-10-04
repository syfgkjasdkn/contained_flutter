import UIKit
import MapKit

//struct Place {
//  let id: Int
//  let name: String
//  let coordinate: CLLocationCoordinate2D
//
//  init(raw: [String: Any]) {
//    id = raw["id"] as! Int
//    name = raw["name"] as! String
//    let rawCoordinate = raw["coordinate"] as! [String: Double]
//    coordinate = CLLocationCoordinate2D(latitude: rawCoordinate["latitude"]!,
//                                        longitude: rawCoordinate["longitude"]!)
//  }
//}

final class MapViewController: UIViewController {
  private let flutterViewController: FlutterViewController = {
    let vc = FlutterViewController()
    vc.view.translatesAutoresizingMaskIntoConstraints = false
    return vc
  }()

  private let mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.translatesAutoresizingMaskIntoConstraints = false
    return mapView
  }()

//  private lazy var flutterChannel: FlutterMethodChannel = { [unowned self] in
//    let channel = FlutterMethodChannel(name: "flutter_examples/map",
//                                       binaryMessenger: flutterViewController)
//    channel.setMethodCallHandler { [weak self] (call, result) in
////      guard let `self` = self else { return }
//      switch call.method {
//      case "choosePlace":
//        let rawCoordinate = call.arguments as! [String: Double]
//        let placeCoordinate = CLLocationCoordinate2D(latitude: rawCoordinate["latitude"]!,
//                                                     longitude: rawCoordinate["longitude"]!)
//        self?.mapView.setCenter(placeCoordinate, animated: true)
//      default:
//        result(FlutterMethodNotImplemented)
//      }
//    }
//
//    return channel
//  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    addChildViewController(flutterViewController)
    view.addSubview(flutterViewController.view)
    flutterViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    flutterViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    flutterViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    flutterViewController.view.heightAnchor.constraint(equalToConstant: 70).isActive = true

    view.addSubview(mapView)
    mapView.bottomAnchor.constraint(equalTo: flutterViewController.view.topAnchor).isActive = true
    mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    let channel = FlutterMethodChannel(name: "flutter_examples/map",
                                       binaryMessenger: flutterViewController)

    channel.setMethodCallHandler { [weak self] (call, result) in
      guard let `self` = self else { return }
      switch call.method {
      case "choosePlace":
        let rawCoordinate = call.arguments as! [String: Double]
        let placeCoordinate = CLLocationCoordinate2D(latitude: rawCoordinate["latitude"]!,
                                                     longitude: rawCoordinate["longitude"]!)
        self.mapView.setCenter(placeCoordinate, animated: true)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
