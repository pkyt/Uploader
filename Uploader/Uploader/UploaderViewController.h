//
//  UploaderViewController.h
//  Uploader
//
//  Created by Pavlo Kytsmey on 4/10/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploaderViewController : UIViewController

- (IBAction)pushPick:(id)sender;
- (IBAction)pushUpload:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
