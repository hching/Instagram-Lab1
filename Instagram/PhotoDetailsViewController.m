//
//  PhotoDetailsViewController.m
//  Instagram
//
//  Created by Henry Ching on 9/14/15.
//  Copyright (c) 2015 Henry Ching. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "PhotoDetailsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *photoDetailsTableView;
@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoDetailsTableView.rowHeight = 320;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (PhotoDetailsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.detailscell"];
    
    NSLog(@"response: %@", self.photoURL);
    [cell.myDetailsImage setImageWithURL:self.photoURL];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
