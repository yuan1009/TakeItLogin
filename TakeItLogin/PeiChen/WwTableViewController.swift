//
//  WwTableViewController.swift
//  Tackit
//
//  Created by 傅培禎 on 2021/3/2.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class WwTableViewController: UITableViewController {
    
    var db: Firestore!
    var storage: Storage!
    var likeMovies = [MovieByPei]()
    var selectedIndex = 0
    var registration: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let likeDicMovies = UserDefaults.standard.object(forKey: "likeMovies") as? [[String: Any]] {
            for dicMovie in likeDicMovies {
                self.likeMovies.append(MovieByPei(documentData: dicMovie))
            }
        }
        tableView.reloadData()

        
//        db = Firestore.firestore()
//        storage = Storage.storage()
//       movies = [MovieByPei]()
//        tableViewAddRefreshControl()
        
//        movies.append(MovieByPei(name: "超時空甩尾",  detail: "上映日期：2021/02/19\n導演：小池健\n類型：動畫、動作\n片長：1 時42分\n劇情簡介：在傳統四輪車被空氣動力車取代的未來世界，有著五年舉辦一次的賽車比賽，這個名為『REDLINE』的賽事，旨在選出宇宙最快賽車手，參賽者除了要有高超的駕駛技巧外，大會是允許所有參賽者使用武器裝備攻擊或干擾他人，也因此比賽過程中險象環生，不僅要心細，還要膽大。然而，外表冷酷、但骨子裡害羞的超熱血純情男JP，堅持駕駛傳統四輪車，只憑著速度來一決勝負；12歲便曾創下「最年少優勝紀錄」的女車手索諾絲，則是為了尋找離家出走、同為賽車手的父親參加比賽，JP深受索諾絲的專心拼命感動，暗自決定不僅要在這場比賽中實現夢想，還要贏得她的芳心。",  image: UIImage(named: "超時空甩尾")!))
//        movies.append(MovieByPei(name: "銀魂",  detail: "上映日期：2021/02/26\n導演：小池健\n類型：動畫\n片長：1 時44分\n劇情簡介：地球毀滅進入倒數計時，曾是盟友的銀時、高杉、桂各懷想法全力奔走，但阻擋他們去路的是某個與他們擁有悲痛牽絆的人物，與曾引導銀時等人的恩師吉田松陽不同人格的~「虛」。\n以星球的生命力「艾特納」能量誕生的魔人「虛」，在長久的歲月中輪迴重生，是不老不死的怪物。其中一度短暫顯現的人格是曾經開設松下村塾，引導幼年銀時等人的老師：吉田松陽…\n為了輔助銀時等人，新八、神樂、真選組、歌舞伎町的人們，甚至連過往的勁敵都將參戰！逐漸巨大化的虛之力、賭上自我性命與之對峙的高杉及遍體鱗傷的銀時，最後看到的景象是…！究竟銀時是否能夠奪回一切…！\n最終而最大的敵人~「虛」，其真面目究竟是…！？。",  image: UIImage(named: "銀魂")!))
//        movies.append(MovieByPei(name: "湯姆貓與傑利鼠",  detail: "上映日期：2021/02/10\n導演：提姆史多利(Tim Story)\n類型：動畫\n片長：1時41分\n劇情簡介：湯姆貓與傑利鼠轉戰大城市，來到紐約展開新生活，並在一間豪華飯店遇上「超殺女」克蘿伊摩蕾茲扮演的飯店新員工。她即將協助舉辦世紀婚禮，而且必須在婚禮前驅逐傑利鼠，於是找到湯姆貓來幫助她，但是計畫當然不是這麼簡單，湯姆貓與傑利鼠這對冤家在飯店裡追追跑跑，展開新的爆笑追逐。\n\n\n\n\n\n\n\n\n\n\n",  image: UIImage(named: "湯姆貓與傑利鼠")!))
//        movies.append(MovieByPei(name: "超時空甩尾",  detail: "上映日期：2021/02/19\n導演：小池健\n類型：動畫、動作\n片長：1 時42分\n劇情簡介：在傳統四輪車被空氣動力車取代的未來世界，有著五年舉辦一次的賽車比賽，這個名為『REDLINE』的賽事，旨在選出宇宙最快賽車手，參賽者除了要有高超的駕駛技巧外，大會是允許所有參賽者使用武器裝備攻擊或干擾他人，也因此比賽過程中險象環生，不僅要心細，還要膽大。然而，外表冷酷、但骨子裡害羞的超熱血純情男JP，堅持駕駛傳統四輪車，只憑著速度來一決勝負；12歲便曾創下「最年少優勝紀錄」的女車手索諾絲，則是為了尋找離家出走、同為賽車手的父親參加比賽，JP深受索諾絲的專心拼命感動，暗自決定不僅要在這場比賽中實現夢想，還要贏得她的芳心。",  image: UIImage(named: "超時空甩尾")!))
//        movies.append(MovieByPei(name: "銀魂",  detail: "上映日期：2021/02/26\n導演：小池健\n類型：動畫\n片長：1 時44分\n劇情簡介：地球毀滅進入倒數計時，曾是盟友的銀時、高杉、桂各懷想法全力奔走，但阻擋他們去路的是某個與他們擁有悲痛牽絆的人物，與曾引導銀時等人的恩師吉田松陽不同人格的~「虛」。\n以星球的生命力「艾特納」能量誕生的魔人「虛」，在長久的歲月中輪迴重生，是不老不死的怪物。其中一度短暫顯現的人格是曾經開設松下村塾，引導幼年銀時等人的老師：吉田松陽…\n為了輔助銀時等人，新八、神樂、真選組、歌舞伎町的人們，甚至連過往的勁敵都將參戰！逐漸巨大化的虛之力、賭上自我性命與之對峙的高杉及遍體鱗傷的銀時，最後看到的景象是…！究竟銀時是否能夠奪回一切…！\n最終而最大的敵人~「虛」，其真面目究竟是…！？。",  image: UIImage(named: "銀魂")!))
//        movies.append(MovieByPei(name: "湯姆貓與傑利鼠",  detail: "上映日期：2021/02/10\n導演：提姆史多利(Tim Story)\n類型：動畫\n片長：1時41分\n劇情簡介：湯姆貓與傑利鼠轉戰大城市，來到紐約展開新生活，並在一間豪華飯店遇上「超殺女」克蘿伊摩蕾茲扮演的飯店新員工。她即將協助舉辦世紀婚禮，而且必須在婚禮前驅逐傑利鼠，於是找到湯姆貓來幫助她，但是計畫當然不是這麼簡單，湯姆貓與傑利鼠這對冤家在飯店裡追追跑跑，展開新的爆笑追逐。\n\n\n\n\n\n\n\n\n\n\n",  image: UIImage(named: "湯姆貓與傑利鼠")!))
        
    
    }
    
    
    func tableViewAddRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(showAllMovies), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        print("showAllMovies()")
//        showAllMovies()
    }
    
    @objc func showAllMovies() {
        db.collection("movies").getDocuments { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("showAllMovies() error: \(error!.localizedDescription)")
                return
            }
            var movies = [MovieByPei]()
            for document in snapshot.documents {
                // 呼叫自訂Spot建構式可以將document data轉成spot
                movies.append(MovieByPei(documentData: document.data()))
            }
            self.likeMovies = movies
            /* 抓到資料後重刷table view */
            self.tableView.reloadData()
            if let control = self.tableView.refreshControl {
                if control.isRefreshing {
                    // 停止下拉更新動作
                    control.endRefreshing()
                }
            }
        }
    }
    
    
    

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "移除收藏") { (action, view, bool) in
            self.likeMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = .red
        // delete.image = UIImage(named: "delete")

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        // true代表滑到底視同觸發第一個動作；false代表滑到底也不會觸發任何動作
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeMovies.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie : MovieByPei
        let cellId = "movieCell"
        
        movie = likeMovies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! WwTableViewCell
//        cell.imgView.image = try? UIImage(data: Data(contentsOf: URL(string: movie.poster)!)
        let urlSring = "URL"
        if let url = URL(string: urlSring) {
        let task = URLSession.shared.dataTask(with: URL(string: movie.poster)!) { (data, response, error) in
                 if let  data = data {
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                 }
                 else{
                    print("err: \(error)")
            }
            
        }
        print("\(URL(string: movie.poster))")
        cell.lebView?.text = movie.movieName
            
        tableView.rowHeight = 180
        tableView.estimatedRowHeight = 0
        
//
//        if movie.poster.isEmpty {
//            cell.imgView.image = UIImage(named: "noImage")
//        } else {
//            // 下載Firebase storage的照片並顯示在ImageView上
//            let imageRef = Storage.storage().reference().child(movie.poster)
//            // 設定最大可下載10M
//            imageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
//                if let imageData = data {
//                    cell.imgView.image = UIImage(data: imageData)
//                } else {
//                    cell.imgView.image = UIImage(named: "noImage")
//                    print(error != nil ? error!.localizedDescription : "Downloading error!")
//                }
//            }
//        }
        
        
        
//        cell.textLabel?.text = movie.name
//        cell.imageView?.image = movie.image
            task.resume()
//        return cell
        
    }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let movies01 = likeMovies[indexPath.row]
            let detailMovie = segue.destination as! DetailMovie
            detailMovie.movies01 = movies01
        }
    }
    
    
        }


    





