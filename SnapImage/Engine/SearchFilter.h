//
//  SearchFilter.h
//  SnapImage
//
//  Created by Arnav Patra on 9/06/14.
//  Copyright (c) 2014 Idiotical Optimist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"

@interface SearchFilter : NSObject

@property(nonatomic, copy) NSString * name;
@property(nonatomic, strong) NSMutableArray * filterIdentifiers;

- (id) initWithName:(NSString *) name filterIdentifiers:(NSString *) identifiers, ...;
- (void) updateSearchParametersForParameter:(SearchParameters *) params index:(int) index;

@end
