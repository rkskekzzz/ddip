//
//  SearchViewController.swift
//  ProjectDDIP
//
//  Created by 차영훈 on 2021/08/24.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {
	
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // 검색을 도와주는 변수
    private var searchCompleter: MKLocalSearchCompleter?
    
    // 검색 지역 범위 설정 변수
    // .world : 전세계
    private var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
//    private var searchRegion: MKCoordinateRegion = mapView.region
    
    // 검색 결과를 배열로 담는다
    var completerResults: [MKLocalSearchCompletion]?

    // tableView에서 선택한 location 정보를 담음
    private var places: MKMapItem? {
        didSet {
            tableView.reloadData()
        }
    }

    // tableView에서 선택한 location 정보를 가져옴
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        // 검색할 유형을 설정
        /*
         .address : 주소 검색
         pointOfInterest : 건물과 같은 특정 지점 검색
         query : 모든 결과 검색
         */
        searchCompleter?.resultTypes = .query
//        mapView가 focus하고 있는 지역 기준으로 검색지역 설정
//        searchCompleter?.region = mapView.region
//        searchRegion 변수가 가지고 있는 지역 기준으로 검색지역 설정
        searchCompleter?.region = searchRegion
	}
    
    // Completer 참조 해제
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchCompleter = nil
    }
    
}


// searchCompleter?.queryFragment 값을 토대로 Location 검색
extension SearchViewController: MKLocalSearchCompleterDelegate {
    // completer가 결과를 업데이트 할때
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completerResults = completer.results
        // tableView reload
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")

        }
    }
}

extension SearchViewController: UITableViewDataSource{
    // 결과 count 값 리턴, 없으면 default 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(completerResults?.count ?? 0)")
        return completerResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else { return UITableViewCell()}
        
        if let suggestion = completerResults?[indexPath.row] {
            cell.titleLabel.text = suggestion.title
            cell.subtitleLabel.text = suggestion.subtitle
            print(suggestion.title)
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 선택 표시 해제
        
        if let suggestion = completerResults?[indexPath.row] {
            search(for: suggestion)
        }
        guard let places = places else {
            return
        }
        let annotationData = MapItemData(
            loc: places.placemark.coordinate.latitude,
            lloc: places.placemark.coordinate.longitude)
        
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "getAnnotationData"), object: nil, userInfo: annotationData.getData())
        
    }
    
    
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest)
    }

    private func search(using searchRequest: MKLocalSearch.Request){
        
        // 검색 지역 설정
        searchRequest.region = searchRegion
        // 검색 유형 설정
        searchRequest.resultTypes = .pointOfInterest
        // MKLocalSearch 생성
        localSearch = MKLocalSearch(request: searchRequest)
        // 비동기로 검색 실행
        localSearch?.start { [unowned self] (response, error) in
            guard error == nil else {
                return
            }
            
            // 검색한 결과 : reponse의 mapItems 값을 가져온다.
            places = response?.mapItems[0]
//          print("위도 경도 : \(places?.placemark.coordinate)") // 위경도 가져옴
            
        }
    }
}
