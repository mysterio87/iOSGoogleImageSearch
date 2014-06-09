//
//  SearchResult.h
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"
#import "SearchResultItem.h"

@interface SearchResult : NSObject

@property (nonatomic, copy) NSString * searchText;
@property (nonatomic, strong) SearchParameters * searchParams;
@property (nonatomic, strong) SearchParameters * nextSearchParams;
@property (nonatomic, strong) NSMutableArray * searchResultItems;

- (id) initWithSearchText:(NSString *) text
             searchParams:(SearchParameters *) params
         nextSearchParams:(SearchParameters *) nextParams;
- (SearchResultItem *) getSearchResultItemForIndexPath:(NSIndexPath *) indexPath;

@end
