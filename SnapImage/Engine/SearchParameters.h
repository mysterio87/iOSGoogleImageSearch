//
//  SearchParameters.h
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CX                  @"cx"
#define API_KEY             @"key"
#define QUERY               @"q"
#define SEARCH_TYPE         @"searchType"
#define IMAGE_SIZE          @"imgSize"
#define RESPONSE_TYPE       @"alt"
#define TOTAL_RESULTS       @"totalResults"
#define START_INDEX         @"start"
#define FILE_TYPE           @"fileType"

@interface SearchParameters : NSObject<NSCopying>

@property (nonatomic, copy) NSString * imgColorType;
@property (nonatomic, copy) NSString * imgSize;
@property (nonatomic, copy) NSString * imgType;
@property (nonatomic, copy) NSString * dateRestrict;
@property (nonatomic, copy) NSString * rights;
@property (nonatomic, copy) NSString * searchQuery;
@property (nonatomic, assign) NSInteger start;

- (id) initWithColorType:(NSString *) colorType
               imageSize:(NSString *) size
               imageType:(NSString *) type
         dateRestriction:(NSString *) date
                  rights:(NSString *) right
                   query:(NSString *) query
                   start:(NSInteger) start;
- (NSMutableDictionary *) getDictionaryData;

@end
