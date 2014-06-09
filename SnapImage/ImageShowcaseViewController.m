//
//  ImageShowcaseViewController.m
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "ImageShowcaseViewController.h"

@interface ImageShowcaseViewController ()

@end

@implementation ImageShowcaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.minimumZoomScale=0.5;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.delegate=self;
    
    [self.imageView setImageWithURL:self.item.fullImageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
