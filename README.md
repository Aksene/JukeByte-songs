# JukeByte
Jukebox style IOS app which is also kind of similar to spotify. Contains music on a server and information about the music on a database. Using swift and Xcode, the app retrieves the list of songs then plays and pause it at request. The application also tracks the number of likes for a song and also plays.



SiteGround Server:
The server was hosted on SiteGround with the help of cPanel. The file manager contained a variety of files, some music files and some were files that were called and exectued by the iOS application or Cron. Cron ran the files "musicUploader" & "artistUploader" every couple minutes or when request. "musicUploader" was in charge of uploading any new music added on the server to the database, while "artistUploader" did the same but for song artists. The like button script was written to update the likes on the database while alle the get files were to query the files and display them on the iphone application. 
  - cPanel(FileManager)
  ![image](https://user-images.githubusercontent.com/33763067/129624005-40f9b3ad-83d8-4339-b61b-3922dad0cba4.png)








PHPMyAdmin Database:
The database keeps track of all the information related to the each song including additionnally tracked things like likes and plays. We also have a view with a couple triggers to keep track of what artist is linked to what song, the goal is to the same for genres and more when we expand the application. 
  - Songs Table
  ![image](https://user-images.githubusercontent.com/33763067/129620678-ea60bf48-8fd5-426b-b17d-7f95a7e0ae4d.png)

  - Artist Table
  ![image](https://user-images.githubusercontent.com/33763067/129620755-3ba48db5-7d5f-4471-9b7e-1b2549f932f7.png)
  
  
  
  
  
  
  
The application consists of a main page for all the songs present on the server and the database songs. On the bottom of the screen is a "now playing bar" which shows what song is playing or nothing if no song is playing.  You can also either skip to the next song or go back to the previous one with the help of two buttons. The second tab on the other hand is the now playing screen, which shows you the details clearly. On the bottom of it is the queue showing the non played songs in shuffled order. You can also like the song through a like button which increments the count on the database. 
1. ![image](https://user-images.githubusercontent.com/33763067/129624326-60ef1706-b855-4543-926d-5081a7b0a954.png)
2. ![image](https://user-images.githubusercontent.com/33763067/129624364-6eb86a5c-5328-4db5-997f-ab593cbcddee.png)
3. ![image](https://user-images.githubusercontent.com/33763067/129624376-d6204fc7-6812-46aa-ab36-5995e6da688c.png)




  
  
  
  
  
  


