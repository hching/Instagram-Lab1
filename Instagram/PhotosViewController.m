//
//  PhotosViewController.m
//  Instagram
//
//  Created by Henry Ching on 9/14/15.
//  Copyright (c) 2015 Henry Ching. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoTableViewCell.h"
#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *photoTableView;
@property (strong, atomic) NSArray *responseData;
@property NSInteger rowselected;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.photoTableView insertSubview:self.refreshControl atIndex:0];
    
    self.photoTableView.rowHeight = 320;
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=f64d2acccfc64ddb95ef21b9421ca0bb"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"response: %@", responseDictionary);
        
        self.responseData = [responseDictionary objectForKey:@"data"];
        [self.photoTableView reloadData];
    }];
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=f64d2acccfc64ddb95ef21b9421ca0bb"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.responseData = [responseDictionary objectForKey:@"data"];
        [self.photoTableView reloadData];

        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) self.responseData.count;
}

- (PhotoTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.cell"];
    NSDictionary *dataObj = self.responseData[indexPath.row];
    NSString *urlString = dataObj[@"images"][@"low_resolution"][@"url"];
    NSURL *url = [[NSURL alloc] initWithString: urlString];
    
    //NSLog(@"response: %@", url);
    [cell.myImage setImageWithURL:url];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.rowselected = indexPath.row;
    [self performSegueWithIdentifier:@"com.yahoo.photoSegway" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"com.yahoo.photoSegway"])
    {
        // Get reference to the destination view controller
        PhotoDetailsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        NSDictionary *dataObj = self.responseData[self.rowselected];
        NSString *urlString = dataObj[@"images"][@"low_resolution"][@"url"];
        NSURL *url = [[NSURL alloc] initWithString: urlString];
        
        //NSLog(@"response: %@", url);
        [vc setPhotoURL:url];
    }
}


@end
