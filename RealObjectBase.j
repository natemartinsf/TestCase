@import "ProxyObject.j"

@implementation RealObjectBase : CPObject
{
	CPMutableDictionary _relationships      @accessors(readonly);
}

-(id)init
{
	self = [super init];
	var proxy;
	if(self)
	{
	  _relationships = [[CPMutableDictionary alloc] init];
    proxy = [[ProxyObject alloc] initWithBaseObject:self];
	}
	if(proxy)
	{
	  return proxy;
	} 
	else
	{
	  return self;
	}
}

-(void)addRelationshipForKey:(CPString)key className:(CPString)className
{
  //CPLog(@"Adding relationship key: "+key+" className: "+className);
		
	//Add the description of the relationship to the dictionary of relationships
	var relationship = [[CPMutableDictionary alloc] initWithObjects: [CPArray arrayWithObjects: key, className]
															forKeys: [CPArray arrayWithObjects: @"key", @"className"]];
											
	[_relationships setObject:relationship forKey:key]; 
	//CPLog(@"Relationships are: "+_relationships);

}

@end