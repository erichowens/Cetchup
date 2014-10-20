//
//  MovieDetailViewController.m
//  Cetchup
//
//  Created by Erich Owens on 10/19/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigMovieImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    NSString *thumbUrl = [self.movie valueForKeyPath:@"posters.original"];
  
    // API cheats and doesn't give you actual high-res
    NSString *originalURL = [thumbUrl stringByReplacingOccurrencesOfString:@"_tmb"
                                      withString:@"_ori"];
    NSLog(@"my URL: %@", originalURL);
    [self.bigMovieImage setImageWithURL:[NSURL URLWithString:originalURL]];
  
     self.scrollView.contentSize = CGSizeMake(320, 1000);
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
