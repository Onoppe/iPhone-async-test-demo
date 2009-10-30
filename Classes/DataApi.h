//
//  Data.h
//  AsyncTestDemo
//
//  Created by Robert Spychala on 10/30/09.
//

#import <Foundation/Foundation.h>


@interface DataApi : NSObject {

    NSMutableData *receivedData;
    
    NSString *result;
}

- (void) callNetwork;

@property (nonatomic, retain) NSString *result;

@end
