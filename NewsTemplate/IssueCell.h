//
//  IssueCell.h
//  NewsTemplate
//
//  Created by Mike Perry on 4/30/13.
//  Copyright (c) 2013 UC App Lab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IssueCell : UICollectionViewCell
@property (nonatomic, strong)IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) IBOutlet UILabel *cellLabel;

- (void)updateProgress:(int)progress;

-(void)loadingProgress:(NSNumber *)nProgress;






@end
