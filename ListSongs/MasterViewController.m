//
//  MasterViewController.m
//  ListSongs
//
//  Created by Michael Beese on 2/18/15.
//  Copyright (c) 2015 MTZ. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MTZSongTableViewCell.h"
@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController
@synthesize searchField;


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

- (void) updateSongList:(NSString *)searchString
{
    NSString* newSearchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *URLString = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@",newSearchString];
    NSURL *searchURL = [NSURL URLWithString:URLString];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        searchURL];
        [self performSelectorInBackground:@selector(fetchedData:)
                               withObject:data];
    });
    
}


- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {

    if ([theTextField.text length] > 0)
    {
        [self updateSongList:theTextField.text];
        [theTextField resignFirstResponder];
        return YES;
    }
    return NO;
}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    self.songs = [json objectForKey:@"results"]; //2
    [self.tableView reloadData];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.searchField)
        self.searchField.delegate = self;

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef CRAJ_ADD_BUTTON
- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#endif

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];

        NSDictionary *song = [self.songs objectAtIndex:indexPath.row];
        controller.songName = [song objectForKey:@"trackName"];

        controller.albumName = [song objectForKey:@"collectionName"];
        controller.artistName = [song objectForKey:@"artistName"];
        controller.price = [song objectForKey:@"trackPrice"];
        controller.releaseDate = [song objectForKey:@"releaseDate"];
        
        controller.audioPreviewURL = [song objectForKey:@"previewUrl"];
        
        controller.artworkURL = [song objectForKey:@"artworkUrl100"];
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTZSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongTableCell" forIndexPath:indexPath];

    NSDictionary *song = [self.songs objectAtIndex:indexPath.row];
    NSString *songName = [song objectForKey:@"trackName"];
    
    NSString *thumbNailURL = [song objectForKey:@"artworkUrl30"];
    UIImage *thumbNail = [UIImage imageWithContentsOfFile:thumbNailURL];
    cell.thumbnail.image = thumbNail;
    NSURL *url = [NSURL URLWithString:thumbNailURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.thumbnail.image = [[UIImage alloc] initWithData:data];
    
    cell.songName.text = songName;
    
    cell.artistName.adjustsFontSizeToFitWidth = NO;
    cell.artistName.numberOfLines = 2;
    cell.artistName.text = [song objectForKey:@"artistName"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

@end
