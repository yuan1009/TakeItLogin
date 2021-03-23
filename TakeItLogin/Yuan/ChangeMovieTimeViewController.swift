//
//  ChangeMovieTimeViewController.swift
//  TastURLSession
//
//  Created by mac on 2021/3/11.
//

import UIKit


class ChangeMovieTimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var showMovieCity: AllMovie!
    var showMovieName: String = ""
    var movieDetail: Movie!
    var newMovieID: String = ""
       
    
    let cinema = "台北信義Takeit影城"
    let textMovieName = "神力女超人1984"
    let textMovieDate = "選擇日期"
    let textMovieTime = "選擇時間"
    let cinemaMovie = ["台北信義Takeit影城","台北京站Takeit影城","林口MITSUI OUTLET Takeit影城","板橋大遠百Takeit影城","新竹大遠百Takeit影城"]
    let movieName = ["神力女超人1984", "逃", "靈魂急轉彎", "緝魂", "末日終結戰", "鬼故事收藏館"]
    let movieDate = ["3月26(星期五)", "3月27(星期六)", "3月28(星期日)", "3月29(星期一)", "3月30(星期二)"]
    let movieTime = ["12:00", "14:00", "16:00", "18:00", "20:00"]
    

    @IBOutlet weak var cinemaMovieTextView: UITextView!
    @IBOutlet weak var movieNameTextView: UITextView!
    @IBOutlet weak var movieDateTextView: UITextView!
    @IBOutlet weak var movieTimeTextView: UITextView!
    
    var cinemaMoviePickerView = UIPickerView()
    var movieNamePickerView = UIPickerView()
    var movieDatePickerView = UIPickerView()
    var movieTimePickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test: \(showMovieName)")
        cinemaMoviePickerView.dataSource = self
        movieNamePickerView.dataSource = self
        movieDatePickerView.dataSource = self
        cinemaMoviePickerView.delegate = self
        movieNamePickerView.delegate = self
        movieDatePickerView.delegate = self
        movieTimePickerView.dataSource = self
        movieTimePickerView.delegate = self
        cinemaMovieTextView.inputView = cinemaMoviePickerView
        movieNameTextView.inputView = movieNamePickerView
        movieDateTextView.inputView = movieDatePickerView
//        cinemaMovieTextView.text = showMovieCity.cinema
        movieNameTextView.text = showMovieName
        movieDateTextView.text = textMovieDate
        movieTimeTextView.inputView = movieTimePickerView
        movieTimeTextView.text = textMovieTime
        if let movie = showMovieCity {
            cinemaMovieTextView.text = movie.cinema
        } else {
            cinemaMovieTextView.text = "選擇影城"
            print("testMovieCity: \(showMovieCity)")
        }
        
       
       
        
        
        cinemaMovieTextView.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        cinemaMovieTextView.layer.borderWidth = 2
        cinemaMovieTextView.backgroundColor = .black
        
        movieNameTextView.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        movieNameTextView.layer.borderWidth = 2
        movieNameTextView.backgroundColor = .black
        
        movieDateTextView.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        movieDateTextView.layer.borderWidth = 2
        movieDateTextView.backgroundColor = .black
        
        movieTimeTextView.layer.borderColor = CGColor(red: 0, green: 0.8, blue: 0.7, alpha: 1)
        movieTimeTextView.layer.borderWidth = 2
        movieTimeTextView.backgroundColor = .black

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cinemaMoviePickerView {
            return cinemaMovie.count
        }else if pickerView == movieNamePickerView {
            return movieName.count
        }else if pickerView == movieDatePickerView {
            return movieDate.count
        }else if pickerView == movieTimePickerView {
            return movieTime.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cinemaMoviePickerView {
            return cinemaMovie[row]
        }else if pickerView == movieNamePickerView {
            return movieName[row]
        }else if pickerView == movieDatePickerView {
            return movieDate[row]
        }else if pickerView == movieTimePickerView {
            return movieTime[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cinemaMoviePickerView {
            cinemaMovieTextView.text = cinemaMovie[row]
        }else if pickerView == movieNamePickerView {
            movieNameTextView.text = movieName[row]
        }else if pickerView == movieDatePickerView {
            movieDateTextView.text = movieDate[row]
        }else if pickerView == movieTimePickerView {
            movieTimeTextView.text = movieTime[row]
        }
//        self.view.endEditing(true)
    }
    
    
        
    
    @IBAction func orderButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Seat", bundle: nil)
                let seatvc = storyboard.instantiateViewController(identifier: "SeatVC") as! SeatVC
                self.navigationController?.pushViewController(seatvc, animated: true)
//        let movieNameInfo = showMovieName
        seatvc.testMovieID = newMovieID
        seatvc.testMovieName = showMovieName
        seatvc.testMovieCity = cinemaMovieTextView.text
        seatvc.testMovieDate = movieDateTextView.text
        seatvc.testMovieTime = movieTimeTextView.text

    }
    
}
