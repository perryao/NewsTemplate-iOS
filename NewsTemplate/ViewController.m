     //
//  ViewController.m
//  NewsTemplate
//
//  Created by Mike Perry on 4/30/13.
//  Copyright (c) 2013 UC App Lab. All rights reserved.
//

#import "ViewController.h"
#import "IssueCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFDownloadRequestOperation.h"
#import "HudView.h"




@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak)IBOutlet UIToolbar *toolBar;
@property (nonatomic, weak)IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *navBarLabel;
//@property (nonatomic, weak) IBOutlet UIBarButtonItem *barButtonItem;
@property (nonatomic, weak) IBOutlet UIProgressView *mainProgressView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)deleteAllIssues;





@end

@implementation ViewController
{
    NSArray *thumbnailArray1;
    NSArray *thumbnailArray;
    NSArray *PDFArray;
    NSArray *urlArray;
    BOOL isDownloaded;
    
    HudView *hudView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"NewCell"];
    IssueCell *cell = [[IssueCell alloc] init];
    cell.cellLabel.text = @"Download";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wooden-planks-6.jpg"]];
    self.toolBar.tintColor = [UIColor grayColor];
    
    self.navBarLabel.text = @"News";
    self.mainProgressView.hidden = YES;

    
    

    //points to local thumbnail images
    thumbnailArray1 = @[@"mag_1.jpg", @"mag_2.jpg", @"mag_3.jpg", @"mag_4.jpg", @"mag_5.jpg", @"mag_6.jpg", @"mag_7.jpg", @"mag_8.jpg", @"mag_9.jpg", @"mag_10.jpg"];
    
    //Points to addresses of thumbnail images
    thumbnailArray = @[@"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_33/image.img.jpg/1365523045606.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_32/image.img.jpg/1347650661396.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_26/image.img.jpg/1332786074387.jpg",@"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_25/image.img.jpg/1323283854872.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_8/image.img.jpg/1323263493169.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_4/image.img.jpg/1323263497968.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage/image.img.jpg/1302263907884.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_0/image.img.jpg/1343848377210.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_1/image.img.jpg/1343848559325.jpg", @"http://magazine.uc.edu/issues/_jcr_content/MainContent/textimage_2/image.img.jpg/1337802257443.jpg"];
    
    //points to local PDFS
    PDFArray = @[@"issue1", @"issue2", @"issue3", @"issue4", @"issue5", @"issue6", @"issue7", @"issue8", @"issue9",@"issue10"];
    
    
    //Points to addresses of PDFS
    urlArray = @[@"http://d27vj430nutdmd.cloudfront.net/3156/153310/8ce11eb1aa49036c2573ccd2f9a4b33feff855fb.1.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/126431/126431.15.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/102969/102969.8.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/83348/83348.1.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/65576/65576.2.pdf", @"http://d27vj430nutdmd.cloudfront.net/3156/53861/53861.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/42931/42931.8.pdf", @"http://d27vj430nutdmd.cloudfront.net/3156/32662/32662.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/23241/23241.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/15888/15888.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/11419/11419.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/8394/Univ_of_Cinci_online-r.pdf",
                 @"http://d27vj430nutdmd.cloudfront.net/3156/8362/5713B_Univ_of_Cincinnati-r.pdf"];
    
    
}

//Remove to allow landscape on main screen
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    return 4;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IssueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.cellLabel.hidden = YES;
    //cell.progressView.hidden = YES;
    cell.progressView.progress = 0.75;
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:[thumbnailArray objectAtIndex:indexPath.row]]];
    return cell;
}
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionReusableView alloc] init];
}
*/

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    IssueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //UIProgressView *progressView = (UIProgressView *)[cell viewWithTag:1000];
    
    //progressView.hidden = NO;
    
    self.navBarLabel.hidden = YES;
    self.mainProgressView.hidden = NO;
    //self.view.userInteractionEnabled = NO;
    [self.activityIndicator startAnimating];
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"issue%ld", (long)indexPath.row]]stringByAppendingPathExtension:@"pdf"];
   

    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:path password:nil];
        if (document != nil)
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            readerViewController.delegate = self;
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:readerViewController animated:YES completion:nil];
            self.mainProgressView.hidden = YES;
            self.navBarLabel.hidden = NO;
            //self.view.userInteractionEnabled = YES;
            [self.activityIndicator stopAnimating];
            
            
        }
    }else {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlArray[indexPath.row]]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully downloaded file to %@", path);
            self.mainProgressView.progress = 0.0;
            ReaderDocument *document = [ReaderDocument withDocumentFilePath:path password:nil];
            if (document != nil)
            {
                ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
                readerViewController.delegate = self;
                readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:readerViewController animated:YES completion:nil];
                self.mainProgressView.hidden = YES;
                self.navBarLabel.hidden = NO;
                self.view.userInteractionEnabled = YES;
                
                [self.activityIndicator stopAnimating];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Download Failed" message:@"There was a problem downloading this issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            self.mainProgressView.hidden = YES;
            self.mainProgressView.progress = 0.0;
            self.navBarLabel.hidden = NO;
            [self.activityIndicator stopAnimating];
            //self.view.userInteractionEnabled = YES;
            NSLog(@"Error: %@", error);
        }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            float percentDone =((float)((int)totalBytesWritten) / (float)((int)totalBytesExpectedToWrite));
            
            self.mainProgressView.progress = percentDone;
            cell.progressView.progress = percentDone;
            
            NSLog(@"Sent %lld of %lld bytes, %@", totalBytesWritten, totalBytesExpectedToWrite, path);
        }];
        
        [operation start];
        
    }
}




- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //fire when a cell is deselected
    
  
   
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //determines size of cell at index. This will be based off of PDF size.

    
    if (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad) {
        CGSize retValue = CGSizeMake(350, 450);
        return retValue;
    }else {
        CGSize retValue = CGSizeMake(145, 200);
        return retValue;
    }
    
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    //UIEdgeInsetsMake(top,left,bottom,right);
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeHUD
{
    [hudView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
    
}

- (IBAction)deleteAllIssues
{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error = nil;

    if ([[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]count] == 0) {
        hudView = [HudView hudInView:self.view animated:YES];
        hudView.text = @"No Issues";
        [self performSelector:@selector(closeHUD) withObject:nil afterDelay:0.6];
    }else if ([[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]count] > 0) {
        for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]) {
            [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
        }
        hudView = [HudView hudInView:self.view animated:YES];
        hudView.text = @"Deleted";
        [self performSelector:@selector(closeHUD) withObject:nil afterDelay:1.5];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Operation Failed" message:[NSString stringWithFormat:@"%d Files Could Not Be Deleted",[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]count] ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        
        
    }
}



//Deleted button from storyboard. Add the button back and hook up this method to use if needed
/*
 - (IBAction)didClickOpenPDF:(UIBarButtonItem *)sender {
 NSString *file = [[NSBundle mainBundle] pathForResource:@"issue1" ofType:@"pdf"];
 ReaderDocument *document = [ReaderDocument withDocumentFilePath:file password:nil];
 if (document != nil)
 {
 ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
 readerViewController.delegate = self;
 readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
 [self presentViewController:readerViewController animated:YES completion:nil];
 }
 }*/



@end
