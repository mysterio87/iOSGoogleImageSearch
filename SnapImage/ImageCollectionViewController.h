//
//  ImageCollectionViewController.h
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
#import "SearchEngine.h"
#import "ImageShowcaseViewController.h"

@interface ImageCollectionViewController : UICollectionViewController<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, SearchEngineDelegate, UIActionSheetDelegate>

@property(nonatomic, strong) NSMutableArray * imageItems;
@property(nonatomic, strong) SearchEngine * engine;

- (void) setUpForSearchQuery:(NSString *) searchQuery;

@end
