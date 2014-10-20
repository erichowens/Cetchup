//
//  MoviesViewController.m
//  Cetchup
//
//  Created by Erich Owens on 10/19/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLabel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
  
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
    self.tableView.rowHeight = 100;
  
    self.title = @"Current Blockbusters";
  
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil]
         forCellReuseIdentifier:@"MovieCell"];
  
    [self doNetworkStuff];
}

-(void)doNetworkStuff {
  NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=gks4m7ra6abcrfs3h76u8aeh&limit=20"];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  
  [SVProgressHUD showWithStatus:@"Talking to Rotten Tomatoes"];
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    if (connectionError) {
      NSLog(@"error: %@", connectionError);
      [self.networkErrorLabel setHidden:NO];
    } else {
      NSLog(@"data: %@", data);
      NSDictionary *responseDictionary =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      
      self.movies = responseDictionary[@"movies"];
      
      [self.tableView reloadData];
    }
  }];
  [SVProgressHUD dismiss];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onRefresh {
  [self doNetworkStuff];
  [self.refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"count: %ld", self.movies.count);
  return self.movies.count;
  //return 100;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"I am displaying row: %ld", indexPath.row);
  
  MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

  NSDictionary *movie = self.movies[indexPath.row];
  //NSLog(@"Movie: %@", movie);
  
  cell.titleLabel.text = movie[@"title"];
  cell.synopsisLabel.text   = movie[@"synopsis"];
  
  NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
  [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  MovieDetailViewController *vc = [[MovieDetailViewController alloc] init];
  vc.movie = self.movies[indexPath.row];
  
  [self.navigationController pushViewController:vc animated:YES];
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
