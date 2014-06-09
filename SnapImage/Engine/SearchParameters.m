//
//  SearchParameters.m
//  SnapImage
//
//  Created by Arnav Patra on 09/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import "SearchParameters.h"

@implementation SearchParameters

- (id) initWithColorType:(NSString *) colorType
               imageSize:(NSString *) size
               imageType:(NSString *) type
         dateRestriction:(NSString *) date
                  rights:(NSString *) right
                   query:(NSString *) query
                   start:(NSInteger) start
{
    if(self = [super init])
    {
        self.imgColorType = colorType;
        self.imgSize = size;
        self.imgType = type;
        self.dateRestrict = date;
        self.rights = right;
        self.searchQuery = query;
        self.start = start;
    }
    
    return self;
}

- (NSMutableDictionary *) getDictionaryData
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    void(^addToDictionaryIfValid)(NSString *, NSString *) = ^(NSString* param, NSString* paramName) {
        if(param != nil && ![param isEqual:@""])
           [dictionary setValue:param forKey:paramName];
    };
    
    addToDictionaryIfValid(self.imgColorType,   @"imgColorType");
    addToDictionaryIfValid(self.imgSize,        @"imgSize");
    addToDictionaryIfValid(self.imgType,        @"imgType");
    addToDictionaryIfValid(self.dateRestrict,   @"dateRestrict");
    addToDictionaryIfValid(self.imgColorType,   @"rights");
    [dictionary setValue:[NSNumber numberWithInt:self.start] forKey:@"start"];
    [dictionary setValue:@"image" forKey:@"searchType"];
    [dictionary setValue:self.searchQuery forKey:QUERY];
    return dictionary;
}

// In the implementation
-(id)copyWithZone:(NSZone *)zone
{
    SearchParameters *another = [[SearchParameters alloc] initWithColorType:self.imgColorType imageSize:self.imgSize imageType:self.imgType dateRestriction:self.dateRestrict rights:self.rights query:self.searchQuery start:self.start];
    
    return another;
}

@end
