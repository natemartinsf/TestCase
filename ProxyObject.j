@import "RealObjectBase.j"

function _invocationIsAttribute(anInvocation)
{
  return ![RealObjectBase instancesRespondToSelector:[anInvocation selector]] || [anInvocation selector] == @"valueForKey:";
}

function _invocationIsRelationship(anInvocation, _real)
{
  var kvcWithRelationship = ([anInvocation selector] == @"valueForKey:") && [[_real _relationships] containsKey:[anInvocation argumentAtIndex:2]];
  return _invocationIsAttribute(anInvocation) && ([[_real _relationships] containsKey:[anInvocation selector]] || kvcWithRelationship);
}

function _getClassFromInvocation(anInvocation, _real)
{
  var theKey;
  if ([anInvocation selector]== @"valueForKey:")
  {
    theKey = [anInvocation argumentAtIndex:2];
  }
  else
  {
    theKey = [anInvocation selector];
  }
  var className = [[[_real _relationships] objectForKey:theKey] objectForKey:@"className"];
  var theClass = CPClassFromString(className);
  return theClass;
}


@implementation ProxyObject : CPProxy
{
  RealObjectBase _realObject;  
}

-(id)initWithBaseObject:(RealObjectBase)theObject
{
  _realObject = theObject;
  
  return self;
}


+ (BOOL)respondsToSelector:(SEL)aSelector
{
    return [[_realObject class] respondsToSelector:aSelector];
}


- (CPMethodSignature)methodSignatureForSelector:(SEL)selector
{
  // does the delegate respond to this selector?
  var selectorString = CPStringFromSelector(selector);

  if ([_realObject respondsToSelector:selector])
  {
    // yes, return the delegate's method signature
    return YES;
  } else {
    // no, return whatever CPObject would return
    return [CPObject methodSignatureForSelector: selector];
  }	
}


- (id)forwardInvocation:(CPInvocation)anInvocation
{  
  CPLog(@"Forwarding...");
  if(_invocationIsAttribute(anInvocation))
    {
      var returnObject;
      if(_invocationIsRelationship(anInvocation, _realObject))
      {
        CPLog(@"tried to access a relationship!");
        //We can create an object, since it will get replaced when the real object loads
        var objectClass = _getClassFromInvocation(anInvocation, _realObject);
        CPLog(@"going to create a "+objectClass);
        returnObject = [[objectClass alloc] init];
      }
      else
      {
        //it's an attribute
        CPLog(@"tried to access an attribute");
        returnObject = @"loading...";
      }
      CPLog(@"Returning an object: "+returnObject);
      [anInvocation setReturnValue:returnObject];
      return returnObject;
    }
      //Anything else is a real method, and should fall through.
  CPLog(@"Not an attribute or relationship sending to real object");
  //If we fall through, or are not fault, we can just pass the method on.
  [anInvocation invokeWithTarget:_realObject];
  return;
}


@end