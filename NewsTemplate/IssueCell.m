//
//  IssueCell.m
//  NewsTemplate
//
//  Created by Mike Perry on 4/30/13.
//  Copyright (c) 2013 UC App Lab. All rights reserved.
//

#import "IssueCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation IssueCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




-(void)loadingProgress:(NSNumber *)nProgress{
    float progress = [nProgress floatValue];
    NSLog(@"Progress %f", progress);
    self.progressView.progress = progress;
}

- (void)updateProgress:(int)progress
{
    self.progressView.progress = progress;
    NSLog(@"Inside updateProgress method and progress is:%d",progress);
}

- (void)updateBar:(NSNumber *)floatNumber
{
    [self.progressView setProgress:[floatNumber floatValue]];
}


- (NSString *)description
{
    return @"This cell is the IssueCell";
}



@end
