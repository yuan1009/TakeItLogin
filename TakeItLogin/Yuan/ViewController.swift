//
//  ViewController.swift
//  TastURLSession
//
//  Created by mac on 2021/2/19.
//

import UIKit
import CoreLocation
import FirebaseStorage
import Firebase
import Foundation


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,
                      CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    let userLocation = CLLocation(latitude: 25.0522293, longitude: 121.5438132)
    var index = 0
    var fraction = 3
    var stars: Int = 3
    var db: Firestore!
    var storage: Storage!
    var dicMovie: [String:Any]!
    var likeDicMovies: [[String:Any]]!
    var like = false
    var showMovies: Movie!
    var allMovie: [AllMovie]!
    
    
    @IBOutlet weak var cinema: UITableView!
    @IBOutlet weak var plot: UITextView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieTimeLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieIMDBLabel: UILabel!
    @IBOutlet var starFraction: [UIImageView]!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBSegueAction func showMovieSA(_ coder: NSCoder) -> MovieViewController? {
        let controller = MovieViewController(coder: coder)
        controller?.loadMovie = showMovies.viedourl
        return controller
    }
    
    @IBSegueAction func showMovieSelect(_ coder: NSCoder) -> ChangeMovieTimeViewController? {
        let controller = ChangeMovieTimeViewController(coder: coder)
        
        controller?.showMovieName = showMovies.movieName
        controller?.newMovieID = showMovies.Movie_ID
        
        return controller
    }
    
    
    
    
    @IBAction func clickLikeMovie(_ button: UIButton) {
        like = !like
        if like {
            likeDicMovies.append(dicMovie)
            print("likeMovie: \(dicMovie!)")
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeDicMovies.removeLast()
            button.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        UserDefaults.standard.setValue(likeDicMovies, forKey: "likeMovies")

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let likeDicMovies = UserDefaults.standard.object(forKey: "likeMovies") as? [[String: Any]] {
            self.likeDicMovies = likeDicMovies
        } else {
            self.likeDicMovies = [[String:Any]]()
        }
        
        
        db = Firestore.firestore()
        storage = Storage.storage()
        //        plots()
        readData()
        allMovie = getAllMovie()

        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()              //請求授權
        locationManager.delegate = self                           //設置定位服務管理器代理
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //精準度
        locationManager.distanceFilter = 1                        //更新頻率
        locationManager.stopUpdatingLocation()                    //定位服務更新
        
        
        
        
    }
   
    func getAllMovie() -> [AllMovie] {
        var getAllMovies = [AllMovie]()
        getAllMovies.append(AllMovie(cinema: "台北信義Takeit影城", caption: "字幕：中文", rating: "保護級", timeOne: "12:00", timeTwo: "14:00", timeThree: "16:00", timeFour: "18:00", fromLocation: CLLocation(latitude: 25.0355248, longitude: 121.5669317)))
        getAllMovies.append(AllMovie(cinema: "台北京站Takeit影城", caption: "字幕：中文", rating: "保護級", timeOne: "12:00", timeTwo: "14:00", timeThree: "16:00", timeFour: "18:00",fromLocation: CLLocation(latitude: 25.0491208, longitude: 121.5163465)))
        getAllMovies.append(AllMovie(cinema: "林口MITSUI OUTLET Takeit影城", caption: "字幕：中文", rating: "保護級", timeOne: "12:00", timeTwo: "14:00", timeThree: "16:00", timeFour: "18:00",fromLocation: CLLocation(latitude: 25.070555, longitude: 121.3626106)))
        getAllMovies.append(AllMovie(cinema: "板橋大遠百Takeit影城", caption: "字幕：中文", rating: "保護級", timeOne: "12:00", timeTwo: "14:00", timeThree: "16:00", timeFour: "18:00",fromLocation: CLLocation(latitude: 25.0136342, longitude: 121.4646749)))
        getAllMovies.append(AllMovie(cinema: "新竹大遠百Takeit影城", caption: "字幕：中文", rating: "保護級", timeOne: "12:00", timeTwo: "14:00", timeThree: "16:00", timeFour: "18:00",fromLocation: CLLocation(latitude: 24.8022227, longitude: 120.9630085)))
        return getAllMovies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovie.count
        
    }
    
    @IBAction func commentButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Seat", bundle: nil)
                let commentvc = storyboard.instantiateViewController(identifier: "CommentDetailVC") as! CommentDetailVC
                self.navigationController?.pushViewController(commentvc, animated: true)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cinemaCell", for: indexPath) as! CinemaTableViewCell
        cell.backgroundColor = UIColor.gray
        
        cell.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        
        cell.timeOneLabel.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        cell.timeOneLabel.layer.borderWidth = 2
        cell.timeTwoLabel.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        cell.timeTwoLabel.layer.borderWidth = 2
        cell.timeThreeLabel.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        cell.timeThreeLabel.layer.borderWidth = 2
        cell.timeFourLabel.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        cell.timeFourLabel.layer.borderWidth = 2
//        db.collection("cinemas").getDocuments{
//            (QuerySnapshot, Error) in
//            if let querySnapshot = QuerySnapshot{
//                for document in querySnapshot.documents{
//                    //                    let distance = self.userLocation.distance(from: document.data()["fromLocation"] as! CLLocation) / 1000
//
//                    cell.cinemaLable.text = document.data()["cinema"] as? String
//                    cell.captionLabel.text = document.data()["caption"] as? String
//                    cell.ratingLabel.text = document.data()["rating"] as? String
//                    cell.timeOneLabel.text = document.data()["timeOne"] as? String
//                    cell.timeTwoLabel.text = document.data()["timeTwo"] as? String
//                    cell.timeThreeLabel.text = document.data()["timeThree"] as? String
//                    cell.timeFourLabel.text = document.data()["timeFour"] as? String
//                    //                    cell.distanceLabel.text = " \(String(format: "%.02f", distance)) KMs"
//
//                }
//            }
//        }
        
        var movieCell: AllMovie
        movieCell = allMovie[indexPath.row]
        
                let distance = userLocation.distance(from: movieCell.fromLocation!) / 1000
        
                cell.cinemaLable.text = movieCell.cinema
                cell.captionLabel.text = movieCell.caption
                cell.ratingLabel.text = movieCell.rating
                cell.timeOneLabel.text = movieCell.timeOne
                cell.timeTwoLabel.text = movieCell.timeTwo
                cell.timeThreeLabel.text = movieCell.timeThree
                cell.timeFourLabel.text = movieCell.timeFour
                cell.distanceLabel.text = " \(String(format: "%.02f", distance)) KM"
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let changeMovieTimeVC = self.storyboard?.instantiateViewController(withIdentifier: "changeMovieTimeVC") as! ChangeMovieTimeViewController
//       let showSelectMovie = allMovie[indexPath.row]
//
//        changeMovieTimeVC.movieDetail = showMovies
//    }
    
    func getMovies(completion: @escaping ([MovieSet]) -> Void) {
        var movieItem = [MovieSet]()
        db.collection("movies").getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                return
            }
            for document in querySnapshot.documents {
                let movie = MovieSet(documentData: document.data())
                movieItem.append(movie)
            }
            completion(movieItem)
        }
    }
        
    func readData(){
        plot.backgroundColor = UIColor.gray
        
        
        db.collection("movies").whereField("Movie_ID", isEqualTo: "\(showMovies.Movie_ID)").getDocuments{
            (QuerySnapshot, Error) in
            if let querySnapshot = QuerySnapshot{
                for document in querySnapshot.documents{
                    self.dicMovie = document.data()
                    
                    
                    self.movieNameLabel.text = document.data()["movieName"] as? String
                    self.movieDateLabel.text = document.data()["release"] as? String
                    self.movieTimeLabel.text = String(document.data()["runtime"] as? TimeInterval ?? 0)
                    self.movieRatingLabel.text = document.data()["rating"] as? String
                    self.movieIMDBLabel.text = document.data()["imdb"] as? String

                    self.plot.text = "導演:  \(String(describing: document.data()["director"] as! String))\n\n演員:  \(String(describing: document.data()["actor"] as! String))\n\n劇情:\n\(String(describing: document.data()["intro"] as! String))"
                    self.plot.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
                    self.plot.textColor = .white
                    self.plot.layer.borderWidth = 2
                    self.plot.backgroundColor = .black
                    

                    let imageAddress = document.data()["poster"]
                    if let imageUrl = URL(string: imageAddress as! String){
                        DispatchQueue.global().async {
                            do{
                                let imageData = try Data(contentsOf: imageUrl)
                                let downLoadImage = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.imageView.image = downLoadImage
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
//                    let imageRef = Storage.storage().reference().child("gs://ios-movie.appspot.com/ios-movies/moneyheist.jpeg")
//                    imageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
//                        if let imageData = data {
//                            self.imageView.image = UIImage(data: imageData)
//                        }
//                    }
                }
            }

        }
        
    }
    
}

