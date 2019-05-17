//
//  ViewController.swift
//  JukeByte
//
//  Created by Abdou K Sene on 1/12/19.
//  Copyright © 2019 Abdou K Sene. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nowPlayingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playPauseButton: UIButton!
    var player: Player!
    var songs: [Song] = []
    /*@IBAction func Artist(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setSession()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        //UIApplication.sharedApplication.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption),name: AVAudioSession.interruptionNotification, object: nil)
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption),name: AVAudioSession.interruptionNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleInterruption", name: AVAudioSessionInterruptionNotification, object: nil)
         */
        
        player = Player()
        //let url = "http://jukebyte.co/music/a.mp3"
        tableView.delegate = self
        tableView.dataSource = self
        //player.playStream(fileURL: "http://jukebyte.co/music/a.mp3")
        // changePlayButton()
       
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        //self.tableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "SongsTableViewCell")

        retrieveSongs()

        //let site = URL(string: url)
        //avPlayer = AVPlayer(url: site!)
    }
    
    //delegate and source for tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! UITableViewCell
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "SongsTableViewCell", for: indexPath) as! SongsTableViewCell
        //cell.mainLabel?.text = songs[indexPath.row].getName()
        
        cell.textLabel?.text = songs[indexPath.row].getName()
        print("POPULATE")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        player.playStream(fileURL: "http://jukebyte.co/music/" + songs[indexPath.row].getName())
        changePlayButton()
        nowPlayingLabel.text = songs[indexPath.row].getName()

    }
    //END
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    func setSession (){
        do{
           try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
                                                        mode: .default,
                                                        policy: .longForm,
                                                        options: [])
        }
        catch{
            print(error)
        }
    }
    
    @IBAction func playpauseButtonClick(_ sender: Any) {
        if (player.avPlayer.rate > 0) {
            player.pauseAudio()
        }else{ player.playAudio()}
        changePlayButton()

    }
    
    func changePlayButton(){
        if(player.avPlayer.rate > 0){
            playPauseButton.setImage(UIImage(named: "pauseIcon"), for: UIControl.State.normal)
        }
        else{
            playPauseButton.setImage(UIImage(named: "playIcon"), for: UIControl.State.normal)
        }
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event!.type == UIEvent.EventType.remoteControl{
            if event!.subtype == UIEvent.EventSubtype.remoteControlPause{
                print("pause")
                player.pauseAudio()
            }
            else if event!.subtype ==  UIEvent.EventSubtype.remoteControlPlay{
                print("playing")
                player.playAudio()
            }
        }
    }
    
    @objc func handleInterruption(notification: NSNotification){
        player.pauseAudio()
        
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        
        /* let interruptionType = AVAudioSessionInterruptionTypeKey(rawValue: interruptionTypeAsObject.unsignedLongVal)
         
         if let type = interruptionType{
         if type == .ended {
         player.playAudio()

            }
        }
        //add heasphone handling
    */}
    
    //Retrieve & Parse Songs
    func retrieveSongs(){
        let path = "http://jukebyte.co/music/getmusic.php"
        
        let url = URL(string: path)
        let session = URLSession.shared
        let task = session.dataTask(with:url!) { (data, response,error) in
            //let retrievedList = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            let retrievedList = String(data: data!, encoding: String.Encoding.utf8)

            print(retrievedList!)
            self.parseSongs(data: retrievedList!)
            print("STORE SONGS")

        }
        task.resume()
        print("GETTING SONGS")
    }
    
    func parseSongs(data: String){
        if (data.contains("*")){
            //let dataArray = (data as String).characters.split(separator: "*" ).map(String.init)
            let dataArray = (data as String).split{$0 == "*"}.map(String.init)
            for item in dataArray{
                let itemData = item.split{$0 == ","}.map(String.init)
                let newSong = Song(id: itemData[0], name: itemData[1], numLikes: itemData[2], numPlays: itemData[3])
                songs.append(newSong!)
                print("PARSING NAME")

            }
            for s in songs{
                print (s.getName())
                print("GET NAME")

            }
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    //END
    
}
