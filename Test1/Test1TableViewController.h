//
//
//  Created by Robert Spychala on 10/29/09.
//

#import <UIKit/UIKit.h>

#import "DataApi.h"

@interface Test1AppDelegate : NSObject {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

@interface Test1TableViewController : UITableViewController {

    DataApi *api;
    NSMutableArray *testNames;
}

@end
