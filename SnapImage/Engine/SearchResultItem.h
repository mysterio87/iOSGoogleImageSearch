//
//  SearchResultItem.h
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultItem : NSObject

@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSURL * thumbNailURL;
@property(nonatomic, copy) NSURL * fullImageURL;

- (id) initWithTitle:(NSString *) p_title
        thumbNailURL:(NSString *) p_thumbnailURL
        fullImageURL:(NSString *) p_fullURL;

@end
