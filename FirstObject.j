@import "RealObjectBase.j"
@import "SecondObject.j"

@implementation FirstObject : RealObjectBase
{
 CPString testAttribute         @accessors;
 SecondObject secondObject       @accessors;
}

- (id)init
{
  if(self = [super init])
  {
    [self addRelationshipForKey:"secondObject" className:"SecondObject"];    
  }
  return self;
}


@end
