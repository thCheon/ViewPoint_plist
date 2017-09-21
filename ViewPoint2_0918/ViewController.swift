//
//  ViewController.swift
//  ViewPoint2_0918
//
//  Created by D7703_22 on 2017. 9. 18..
//  Copyright © 2017년 D7703_22. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMV: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locateToCenter()
        
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path = \(String(describing: path))!")
        
        let contents = NSArray(contentsOfFile: path!)
        print("contents =\(String(describing: contents))!")
        
        var annotations = [MKPointAnnotation]()
        
        if let myItems = contents {
            for item in myItems {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                print("let =\(String(describing: item))!")
                
                let annotation = MKPointAnnotation()
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                let mytitle = title as? String
                let mysubTitle = subTitle as? String
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = mytitle
                annotation.subtitle = mysubTitle
                annotations.append(annotation)
                
            }
        } else {
            print ("contents는 nil")
        }
        
        myMV.delegate = self

        
        myMV.showAnnotations(annotations, animated: true)
        myMV.addAnnotations(annotations)
    }
    
    
    func locateToCenter() {
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        myMV.setRegion(region, animated: true)
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        var annotationView = myMV.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView (annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            if annotation.title! == "부산 시민공원" {
                annotationView?.pinTintColor = UIColor.green
            } else
            if annotation.title! == "송상현광장"{
                annotationView?.pinTintColor = UIColor.blue
            }
        }else {
            annotationView?.annotation = annotation
        }
        
        let IconView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        let IconView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        let IconView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        
        IconView1.image = UIImage(named: "1.jpeg")
        IconView2.image = UIImage(named: "2.jpg")
        IconView3.image = UIImage(named: "bright-7.png")
        
        if annotation.title! == "부산 시민공원" {
            annotationView?.leftCalloutAccessoryView = IconView1
        } else if annotation.title! == "동의과학대학교" {
            annotationView?.leftCalloutAccessoryView = IconView2
        } else if annotation.title! == "송상현광장" {
            annotationView?.leftCalloutAccessoryView = IconView3
        }
        
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        print("callout Accessoty Tapped!")
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let ViewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        print("\(viewTitle) \(ViewSubTitle)")
        
        let ac = UIAlertController(title: viewTitle, message: ViewSubTitle, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

}

