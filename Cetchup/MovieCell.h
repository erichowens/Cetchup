//
//  MovieCell.h
//  Cetchup
//
//  Created by Erich Owens on 10/19/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
