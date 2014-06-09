//
//  SearchEngine.h
//  SnapImage
//
//  Created by Arnav Patra on 08/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSMutableDictionary * searchFilters;

@protocol SearchEngineDelegate;
@class SearchParameters;

@interface SearchEngine : AFHTTPSessionManager
@property (nonatomic, weak) id<SearchEngineDelegate>delegate;

+ (SearchEngine *)sharedSearchEngine;
+ (NSMutableDictionary *) filters;
//- (instancetype)initWithBaseURL;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void) updateSearchWithParameters:(SearchParameters *) params;
@end

#pragma mark - Search Engine Protocol

@protocol SearchEngineDelegate <NSObject>
@optional
-(void)searchEngine:(SearchEngine *)engine didUpdateWithResults:(id)results;
-(void)searchEngine:(SearchEngine *)engine didFailWithError:(NSError *)error;
@end

