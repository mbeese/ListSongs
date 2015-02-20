# ListSongs
Summary: A simple iOS master-detail app that lists songs of an artist on iTunes.  

Key Functionality: 
1. The app was developed starting with the split view controller template project.

2. The MasterViewController class is derived from UITableViewController.  The MasterViewController class has a method UpdateSongList updates the table based on a single search string.  The method uses dispatch_async with a selector that is performed in the background.  The fact that the web request and JSON parsing are done in a background thread can be verified by observing that  the user interface remains responsive while the app is downloading a new list of songs.  

3. A custom class derived from UITableViewCell was created to show the master view's menu of songs including the song name, an icon and the artist's name.  

4. The DetailViewController class shows the album name, artist name, price, release date and a circular rendering of the album art.  The image was displayed as circular by setting the cornerRadius of the Layer of the UIImageView to half the width of the image.  The layer's maskToBounds flag was also set to YES.

5. Date formatting was a particular challenge because the date strings for release date were formatted using a format that is unrecognized by the NSDateFormatter class.  Therefore, a custom method was added to the DetailViewController to convert a date string with this format: "2014-05-27T07:00:00Z" to one of this format: "May 27, 2014" omitting the time.

6. By default the app comes up with a search field that shows the name "Michael Beese".  All my electric violin music on iTunes shows up in the master view after the app launches.  The user can then type a new search term or terms such as "Jack Johnson" and the master view updates with a different selection of songs.

Cool Things To Do With More Time:

1. The launch screen specified in LaunchScreen.xib is not in the storyboard.  Currently, it does not show, but the preferred solution would be a launch image.

2. Add an app icon.  Right now the app uses the default iOS 7+ icon.

3. Better use of images in the detail view.  Currently the image view is sized to fill the view.  There are a number of image resources associated with each song and these can be accessed using keys such as "artworkUrl30", "artworkUrl60" and "artworkUrl100".  The app uses "artworkUrl100" and puts the image into a UIImageView of size 220 x 220, but the image is a little blurry at that size.  With more time all the image keys would be tested with various sizes for the image view.


