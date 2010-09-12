/*
 * AppController.j
 * TestCase
 *
 * Created by You on September 12, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "FirstObject.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
}

- (id)init
{
    if (self = [super init])
    {
        CPLogRegister(CPLogPopup);
    }
    return self;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    
    var theFirstObject = [[FirstObject alloc] init];
    CPLog(@"The first Object is: "+theFirstObject);
    var firstObjectAttribute = [theFirstObject testAttribute];
    CPLog(@"The first attribute is: "+firstObjectAttribute);
    var secondObject = [theFirstObject secondObject];
    CPLog(@"The second Object is: "+secondObject);
    var secondObjectAttribute = [secondObject testAttribute];
    CPLog(@"The second attribute is: "+secondObjectAttribute);
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
}

@end
