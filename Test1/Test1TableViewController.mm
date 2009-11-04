//
//
//  Created by Robert Spychala on 10/29/09.
//

#import "Test1TableViewController.h"
#import "DataApi.h"


#pragma mark -


int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}












#pragma mark -

@implementation Test1AppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end












#pragma mark -


@implementation Test1TableViewController

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //number of tests
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d) %@", indexPath.row+1, [testNames objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    return cell;   
}

-(void) viewDidAppear:(BOOL)animated {
 
    [self performSelector:@selector(startTests) withObject:nil afterDelay:0];
}

- (void)dealloc {
    [super dealloc];
}

-(void) setMessage:(NSIndexPath*)indexPath messageSuffix:(NSString*) messageSuffix {

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d) %@ %@", indexPath.row+1, [testNames objectAtIndex:indexPath.row], messageSuffix];
    [testNames replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%@ %@", [testNames objectAtIndex:indexPath.row], messageSuffix]];
    
    [cell setNeedsDisplay];
    
    if ([testNames count] > indexPath.row+1) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void) viewDidLoad {

    testNames = [[NSMutableArray arrayWithObjects:@"test apple.com for Apple", @"test apple.com for Tablet", nil] retain];
}

-(void) startTests {
    
    [self performSelector:@selector(test_1:) withObject:nil afterDelay:0];
}







/////////////////////////////
////
//// test chain
////













- (void)test_1:(id)obj {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_1_apiStart:) name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_1_apiError:) name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_1_apiFinished:) name:@"unitTestFinished" object:nil];
	    
    api = [[DataApi alloc] init];
    [api callNetwork];
}

- (void) test_1_apiStart:(id)obj {
    
    
}

- (void)test_1_apiError:(id)obj {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestFinished" object:nil];
    
    [self setMessage:[NSIndexPath indexPathForRow:0 inSection:0] messageSuffix:@" ... FAIL"]; 
}

- (void)test_1_apiFinished:(id)obj {
        
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestFinished" object:nil];
    
    if ([api.result rangeOfString:@"Apple"].location != NSNotFound) {
    
        [self setMessage:[NSIndexPath indexPathForRow:0 inSection:0] messageSuffix:@" ... ok"];
        
    } else {
        
        [self setMessage:[NSIndexPath indexPathForRow:0 inSection:0] messageSuffix:@" ... fail"];
    }
    
    [self performSelector:@selector(test_2:) withObject:nil afterDelay:0];
}














- (void)test_2:(id)obj {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_2_apiStart:) name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_2_apiError:) name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test_2_apiFinished:) name:@"unitTestFinished" object:nil];
    
    [api release];
    api = [[DataApi alloc] init];
    [api callNetwork];
}

- (void) test_2_apiStart:(id)obj {
    
    
}

- (void)test_2_apiError:(id)obj {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestFinished" object:nil];
    
    [self setMessage:[NSIndexPath indexPathForRow:1 inSection:0] messageSuffix:@" ... FAIL"]; 
}

- (void)test_2_apiFinished:(id)obj {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestStart" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestError" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unitTestFinished" object:nil];
    
    if ([api.result rangeOfString:@"Tablet"].location != NSNotFound) {
        
        [self setMessage:[NSIndexPath indexPathForRow:1 inSection:0] messageSuffix:@" ... ok"];
        
    } else {
        
        [self setMessage:[NSIndexPath indexPathForRow:1 inSection:0] messageSuffix:@" ... fail"];
    }
}


@end
