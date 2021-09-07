//
//  MeetingViewController.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import UIKit
import MapKit


class MeetingViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var panelUp: () -> Void = {}
    
    lazy var stackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [ddayLabel, titleAndPeopleStackView, dateAndMoneyStackView ,joinButton])
        
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 10
        stackV.distribution = .fillEqually
        
        return stackV
    }()
    
    lazy var titleAndPeopleStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [titleLabel, numberOfPeopleLabel])
        
        return stackV
    }()
    
    lazy var dateAndMoneyStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [dateAndTimeStackView, moneyLabel])
        
        return stackV
    }()
    
    lazy var dateAndTimeStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        
        return stackV
    }()
    
    lazy var joinButton: UIButton = {
        let height: CGFloat = 50
        let weight: CGFloat = self.view.frame.width - 70
        let button = UIButton(frame: CGRect.init(x: (self.view.frame.size.width - weight) / 2,
                                                 y: (self.view.frame.size.height - height) / 4,
                                                 width: weight,
                                                 height: height))
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        button.backgroundColor = UIColor.black
        button.setTitle("Join Event", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var ddayLabel: UILabel = {
        let dday = UILabel()
        
        
        dday.text = "6시간 후 시작"
        dday.textColor = UIColor(rgb: 0x87b8b7)
        return dday
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        
        
        title.text = "면접 스터디 모임"
        title.font = UIFont.boldSystemFont(ofSize: 30)
        return title
    }()
    
    lazy var numberOfPeopleLabel: UILabel = {
        let numberOfPeople = UILabel()
        
        numberOfPeople.text = "9 / 10"
        numberOfPeople.textColor = .gray
        return numberOfPeople
    
    }()
    
    lazy var dateLabel: UILabel = {
        let date = UILabel()
        
        date.text = "date"
        return date
    }()
    
    lazy var timeLabel: UILabel = {
        let time = UILabel()
        
        time.text = "time"
        return time
    }()
    
    lazy var moneyLabel: UILabel = {
        let money = UILabel()
        
        money.text = "money"
        return money
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton(frame: CGRect.init(x: (self.view.frame.size.width - weight) / 2,
//                                                 y: (self.view.frame.size.height - height) / 4,
//                                                 width: weight,
//                                                 height: height))
//        button.backgroundColor = .green
//        button.layer.cornerRadius = 25
//        button.layer.shadowColor = UIColor.gray.cgColor
//        button.layer.shadowOpacity = 1.0
//        button.layer.shadowOffset = CGSize.zero
//        button.layer.shadowRadius = 6
//        button.backgroundColor = UIColor.black
//        button.setTitle("Join Event", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
            .isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
        
//        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//

        
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
}

extension MeetingViewController: MapViewControllerDelegate {
    func didUpdateMapVCAnnotation(annotationObject: AnnotationObject) {
        DispatchQueue.main.async {
            self.panelUp()
            
            //			print(annotationObject.locationName as Any)
            //			print(annotationObject.coordinate.latitude)
            //			print(annotationObject.coordinate.longitude)
            //			print(annotationObject.discipline as Any)
        }
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
