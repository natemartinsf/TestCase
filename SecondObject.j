@import "RealObjectBase.j"

@implementation SecondObject : RealObjectBase
{
 CPString testAttribute         @accessors;
}

- (id)init
{
  if(self = [super init])
  {
  }
  return self;
}


@end
