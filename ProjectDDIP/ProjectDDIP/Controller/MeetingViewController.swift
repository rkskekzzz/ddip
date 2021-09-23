//
//  MeetingViewController.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/29.
//

import MapKit
import UIKit

class MeetingViewController: UIViewController {
    var createPanel: () -> Void = {}
    var removePanel: () -> Void = {}

    lazy var stackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [ddayLabel, titleAndPeopleStackView, dateAndMoneyStackView, joinButton])

        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 10
        stackV.distribution = .equalCentering

        // debug
        stackV.layer.borderColor = UIColor.red.cgColor
        stackV.layer.borderWidth = 1

        return stackV
    }()

    lazy var titleAndPeopleStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [titleLabel, numberOfPeopleLabel])

        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .horizontal
//        stackV.alignment = .bottom
        stackV.spacing = 10
        stackV.distribution = .equalSpacing

        // debug
        stackV.layer.borderColor = UIColor.green.cgColor
        stackV.layer.borderWidth = 1

        return stackV
    }()

    lazy var dateAndMoneyStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [dateAndTimeStackView, moneyLabel])

        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .horizontal
        stackV.spacing = 10
        stackV.distribution = .fillEqually

        return stackV
    }()

    lazy var dateAndTimeStackView: UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 2
        stackV.distribution = .fillEqually

        return stackV
    }()

//    lazy var ddayLabelFrame: UIView = {
//        let ddayLabelF = UIView(frame: CGRect(x: 0,
//                                              y: 0,
//                                              width: 100,
//                                              height: 40))
//
//        // debug
//        ddayLabelF.layer.borderColor = UIColor.green.cgColor
//        ddayLabelF.layer.borderWidth = 1
//
//
//        // debug
//        print(ddayLabel.text)
    ////        ddayLabelF.addSubview(ddayLabel)
//
//        return ddayLabelF
//    }()
//
//    lazy var titleAndPeopleStackViewFrame: UIView = {
//        let titleAndPeopleStackViewF = UIView(frame: CGRect.init(x: 0,
//                                                                y: 0,
//                                                                width: self.stackView.frame.size.width,
//                                                                height: (self.stackView.frame.size.height / 4) - 10))
//        titleAndPeopleStackViewF.addSubview(titleAndPeopleStackView)
//        return titleAndPeopleStackViewF
//    }()

//    lazy var dateAndMoneyStackViewFrame: UIView = {
//        let dateAndMoneyStackViewF = UIView(frame: CGRect.init(x: 0,
//                                                                y: 0,
//                                                                width: self.stackView.frame.size.width,
//                                                                height: (self.stackView.frame.size.height / 4) - 10))
//        dateAndMoneyStackViewF.addSubview(dateAndMoneyStackView)
//        return dateAndMoneyStackViewF
//    }()
//
//    lazy var joinButtonFrame: UIView = {
//        let joinButtonFrameF = UIView(frame: CGRect.init(x: 0,
//                                                                y: 0,
//                                                                width: self.stackView.frame.size.width,
//                                                                height: (self.stackView.frame.size.height / 4) - 10))
//        joinButtonFrameF.addSubview(joinButton)
//        return joinButtonFrameF
//    }()

    lazy var ddayLabel: UILabel = {
        let dday = UILabel()

        dday.text = "6시간 후 시작"
        dday.textColor = UIColor(rgb: 0x87B8B7)

        // debug
        dday.layer.borderColor = UIColor.blue.cgColor
        dday.layer.borderWidth = 1

        return dday
    }()

    lazy var titleLabel: UILabel = {
        let title = UILabel()

        title.text = "면접 스터디 모임"
        title.font = UIFont.boldSystemFont(ofSize: 30)

        // debug
        title.layer.borderColor = UIColor.black.cgColor
        title.layer.borderWidth = 1

        return title
    }()

    lazy var numberOfPeopleLabel: UILabel = {
        let numberOfPeople = UILabel()

        numberOfPeople.text = "9 / 10"
        numberOfPeople.textColor = .gray

        // debug
        numberOfPeople.layer.borderColor = UIColor.black.cgColor
        numberOfPeople.layer.borderWidth = 1

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

    lazy var joinButton: UIButton = {
        let height: CGFloat = 50
        let weight: CGFloat = self.view.frame.width - 70
        let button = UIButton(frame: CGRect(x: (self.view.frame.size.width - weight) / 2,
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

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
            .isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true

//        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
    }

    @objc func buttonAction(sender _: UIButton!) {
        print("Button tapped")
        removePanel()
    }
}

extension MeetingViewController: MapViewControllerDelegate {
    func didUpdateMapVCAnnotation(annotationPin _: AnnotationPin) {
        DispatchQueue.main.async {
            self.createPanel()
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
