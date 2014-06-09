//
//  ImageShowcaseViewController.h
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultItem.h"
#import "UIImageView+AFNetworking.h"

@interface ImageShowcaseViewController : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) IBOutlet UIScrollView * scrollView;
@property(nonatomic, strong) IBOutlet UIImageView * imageView;
@property(nonatomic, strong) SearchResultItem * item;

@end
