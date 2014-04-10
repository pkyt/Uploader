//
//  UploaderViewController.m
//  Uploader
//
//  Created by Pavlo Kytsmey on 4/10/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "UploaderViewController.h"

@interface UploaderViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation UploaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushPick:(id)sender {
    UIImagePickerController* picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (IBAction)pushUpload:(id)sender {
    NSLog(@"upload starts");
    NSString* filename = @"picture.jpg";
    if (self.imageView.image) {
        NSData* imageData = UIImageJPEGRepresentation(self.imageView.image, 90);
        NSString* urlString = @"http://localhost:3490/upload.php";
        NSMutableURLRequest* request = [NSMutableURLRequest new];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString* boundary = @"---------147278098315645634534568381242314234";
        NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSMutableData * body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSData* returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString* returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"Ends with return string: %@", returnString);
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
