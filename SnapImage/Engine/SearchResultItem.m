//
//  SearchResultItem.m
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "SearchResultItem.h"

@implementation SearchResultItem

- (id) initWithTitle:(NSString *) p_title
        thumbNailURL:(NSString *) p_thumbnailURL
        fullImageURL:(NSString *) p_fullURL
{
    if(self = [super init])
    {
        self.title = p_title;
        self.thumbNailURL = [NSURL URLWithString:p_thumbnailURL];
        self.fullImageURL = [NSURL URLWithString:p_fullURL];
    }
    
    return self;
}

@end
