//
//  DetailViewController.m
//  ListSongs
//
//  Created by Michael Beese on 2/18/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()

@end

@implementation DetailViewController


@synthesize songName;
@synthesize albumName;
@synthesize artistName;
@synthesize price;
@synthesize releaseDate;
@synthesize artworkURL;
@synthesize audioPreviewURL;

#pragma mark - Managing the detail item


-(void)playselectedsong{
    
    if (self.audioPreviewURL == nil)
        return;
    
    NSString *urlString = self.audioPreviewURL;
    AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:urlString]];
    self.audioPlayer = player;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
//    [self.audioPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    [self.audioPlayer play];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.audioPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.audioPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (self.audioPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            
        } else if (self.audioPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    
}



- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}
- (NSString *)convertDateString:(NSString *)dateString
{
//"2014-05-27T07:00:00Z"
    NSArray *dateTimeComponents = [dateString componentsSeparatedByString:@"T"];
    NSString *dateTimeString = [dateTimeComponents objectAtIndex:0];
    
    NSArray *dateComponents = [dateTimeString componentsSeparatedByString:@"-"];
    NSString *yearString = [dateComponents objectAtIndex:0];
    NSString *monthString = [dateComponents objectAtIndex:1];
    int month = [monthString intValue];
    NSString *dayString = [dateComponents objectAtIndex:2];
    
    switch(month)
    {
        case 0:
            monthString = @"Jan";
            break;
        case 1:
            monthString = @"Feb";
            break;
        case 2:
            monthString = @"Mar";
            break;
        case 3:
            monthString = @"Apr";
            break;
        case 4:
            monthString = @"May";
            break;
        case 5:
            monthString = @"Jun";
            break;
        case 6:
            monthString = @"Jul";
            break;
        case 7:
            monthString = @"Aug";
            break;
        case 8:
            monthString = @"Sep";
            break;
        case 9:
            monthString = @"Oct";
            break;
        case 10:
            monthString = @"Nov";
            break;
        case 11:
            monthString = @"Dec";
            break;
    }
    
    return [NSString stringWithFormat:@"Release Date: %@ %@, %@",monthString,dayString,yearString];
}
- (void)configureView {
    // Update the user interface for the detail item.
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSDictionary *song = appDelegate.selectedSong;
    if (song == nil)
        return;
    
    self.songName = [song objectForKey:@"trackName"];
    
    if (self.songName == nil)
        return;
    self.albumName = [song objectForKey:@"collectionName"];
    self.artistName = [song objectForKey:@"artistName"];
    self.price = [song objectForKey:@"trackPrice"];
    self.releaseDate = [song objectForKey:@"releaseDate"];
    
    self.audioPreviewURL = [song objectForKey:@"previewUrl"];
    
    self.artworkURL = [song objectForKey:@"artworkUrl100"];
    
    self.navigationItem.title = self.songName;
    self.albumNameLabel.text = [NSString stringWithFormat:@"%@",self.albumName];
    self.artistNameLabel.text = [NSString stringWithFormat:@"Artist: %@",self.artistName];
    self.pricelabel.text = [NSString stringWithFormat:@"Price: $%@",self.price];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.artworkURL]];
    
    self.artwork.image = [UIImage imageWithData: imageData];
    NSString *dateString = [self convertDateString:self.releaseDate];
    
    self.releaseDateLabel.text = dateString;
    
    self.artwork.layer.cornerRadius = self.artwork.frame.size.width/2.0;
    self.artwork.layer.masksToBounds = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self playselectedsong];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
