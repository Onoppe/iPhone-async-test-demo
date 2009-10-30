//
//  Data.m
//  AsyncTestDemo
//
//  Created by Robert Spychala on 10/30/09.
//

#import "DataApi.h"


@implementation DataApi

@synthesize result;

-(void) callNetwork {
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData that will hold
        // the received data
        // receivedData is declared as a method instance elsewhere
        receivedData=[[NSMutableData data] retain];
        
        #ifdef UNIT_TEST
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unitTestStart" object:nil];
        #endif
    } else {
        // inform the user that the download could not be made
    }
}

#pragma mark NSURLConnection shizza

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
    
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
    
    #ifdef UNIT_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unitTestError" object:nil];
    #endif    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    result = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];

    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
    
    #ifdef UNIT_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unitTestFinished" object:nil];
    #endif        
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSuccess" object:nil];
    
}

@end
