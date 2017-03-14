//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//

#include "AndroidOsLooper.h"
#include "DeGreenrobotEventEventBus.h"
#include "DeGreenrobotEventTestAbstractEventBusTest.h"
#include "DeGreenrobotEventTestEventBusMainThreadTest.h"
#include "IOSClass.h"
#include "IOSObjectArray.h"
#include "J2ObjC_source.h"
#include "java/lang/InterruptedException.h"
#include "java/lang/RuntimeException.h"
#include "java/lang/Thread.h"
#include "java/lang/annotation/Annotation.h"
#include "java/util/ArrayList.h"
#include "java/util/List.h"
#include "junit/framework/TestCase.h"
#include "org/junit/Before.h"
#include "org/junit/Test.h"

@interface DeGreenrobotEventTestEventBusMainThreadTest () {
 @public
  DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *backgroundPoster_;
}

@end

J2OBJC_FIELD_SETTER(DeGreenrobotEventTestEventBusMainThreadTest, backgroundPoster_, DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *)

__attribute__((unused)) static IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$0();

__attribute__((unused)) static IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$1();

__attribute__((unused)) static IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$2();

@interface DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster () {
 @public
  DeGreenrobotEventTestEventBusMainThreadTest *this$0_;
  id<JavaUtilList> eventQ_;
  id<JavaUtilList> eventsDone_;
}

- (id)pollEvent;

@end

J2OBJC_FIELD_SETTER(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster, eventQ_, id<JavaUtilList>)
J2OBJC_FIELD_SETTER(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster, eventsDone_, id<JavaUtilList>)

__attribute__((unused)) static id DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_pollEvent(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *self);

@implementation DeGreenrobotEventTestEventBusMainThreadTest

J2OBJC_IGNORE_DESIGNATED_BEGIN
- (instancetype)init {
  DeGreenrobotEventTestEventBusMainThreadTest_init(self);
  return self;
}
J2OBJC_IGNORE_DESIGNATED_END

- (void)setUp {
  [super setUp];
  JreStrongAssignAndConsume(&backgroundPoster_, new_DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_initWithDeGreenrobotEventTestEventBusMainThreadTest_(self));
  [backgroundPoster_ start];
}

- (void)tearDown {
  [((DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *) nil_chk(backgroundPoster_)) shutdown];
  [((DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *) nil_chk(backgroundPoster_)) join];
  [super tearDown];
}

- (void)testPost {
  [((DeGreenrobotEventEventBus *) nil_chk(eventBus_)) register__WithId:self];
  [((DeGreenrobotEventEventBus *) nil_chk(eventBus_)) postWithId:@"Hello"];
  [self waitForEventCountWithInt:1 withInt:1000];
  JunitFrameworkTestCase_assertEqualsWithId_withId_(@"Hello", JreLoadVolatileId(&lastEvent_));
  JunitFrameworkTestCase_assertEqualsWithId_withId_([((AndroidOsLooper *) nil_chk(AndroidOsLooper_getMainLooper())) getThread], JreLoadVolatileId(&lastThread_));
}

- (void)testPostInBackgroundThread {
  [((DeGreenrobotEventEventBus *) nil_chk(eventBus_)) register__WithId:self];
  [((DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *) nil_chk(backgroundPoster_)) postWithId:@"Hello"];
  [self waitForEventCountWithInt:1 withInt:1000];
  JunitFrameworkTestCase_assertEqualsWithId_withId_(@"Hello", JreLoadVolatileId(&lastEvent_));
  JunitFrameworkTestCase_assertEqualsWithId_withId_([((AndroidOsLooper *) nil_chk(AndroidOsLooper_getMainLooper())) getThread], JreLoadVolatileId(&lastThread_));
}

- (void)onEventMainThreadWithNSString:(NSString *)event {
  [self trackEventWithId:event];
}

- (void)dealloc {
  RELEASE_(backgroundPoster_);
  [super dealloc];
}

+ (const J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { NULL, NULL, 0x1, -1, -1, -1, -1, -1, -1 },
    { NULL, "V", 0x1, -1, -1, 0, -1, 1, -1 },
    { NULL, "V", 0x4, -1, -1, 0, -1, -1, -1 },
    { NULL, "V", 0x1, -1, -1, 2, -1, 3, -1 },
    { NULL, "V", 0x1, -1, -1, 2, -1, 4, -1 },
    { NULL, "V", 0x1, 5, 6, -1, -1, -1, -1 },
  };
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wobjc-multiple-method-names"
  methods[0].selector = @selector(init);
  methods[1].selector = @selector(setUp);
  methods[2].selector = @selector(tearDown);
  methods[3].selector = @selector(testPost);
  methods[4].selector = @selector(testPostInBackgroundThread);
  methods[5].selector = @selector(onEventMainThreadWithNSString:);
  #pragma clang diagnostic pop
  static const J2ObjcFieldInfo fields[] = {
    { "backgroundPoster_", "LDeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster;", .constantValue.asLong = 0, 0x2, -1, -1, -1, -1 },
  };
  static const void *ptrTable[] = { "LJavaLangException;", (void *)&DeGreenrobotEventTestEventBusMainThreadTest__Annotations$0, "LJavaLangInterruptedException;", (void *)&DeGreenrobotEventTestEventBusMainThreadTest__Annotations$1, (void *)&DeGreenrobotEventTestEventBusMainThreadTest__Annotations$2, "onEventMainThread", "LNSString;", "LDeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster;" };
  static const J2ObjcClassInfo _DeGreenrobotEventTestEventBusMainThreadTest = { "EventBusMainThreadTest", "de.greenrobot.event.test", ptrTable, methods, fields, 7, 0x1, 6, 1, -1, 7, -1, -1, -1 };
  return &_DeGreenrobotEventTestEventBusMainThreadTest;
}

@end

void DeGreenrobotEventTestEventBusMainThreadTest_init(DeGreenrobotEventTestEventBusMainThreadTest *self) {
  DeGreenrobotEventTestAbstractEventBusTest_init(self);
}

DeGreenrobotEventTestEventBusMainThreadTest *new_DeGreenrobotEventTestEventBusMainThreadTest_init() {
  J2OBJC_NEW_IMPL(DeGreenrobotEventTestEventBusMainThreadTest, init)
}

DeGreenrobotEventTestEventBusMainThreadTest *create_DeGreenrobotEventTestEventBusMainThreadTest_init() {
  J2OBJC_CREATE_IMPL(DeGreenrobotEventTestEventBusMainThreadTest, init)
}

IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$0() {
  return [IOSObjectArray arrayWithObjects:(id[]){ create_OrgJunitBefore() } count:1 type:JavaLangAnnotationAnnotation_class_()];
}

IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$1() {
  return [IOSObjectArray arrayWithObjects:(id[]){ create_OrgJunitTest(OrgJunitTest_None_class_(), 0) } count:1 type:JavaLangAnnotationAnnotation_class_()];
}

IOSObjectArray *DeGreenrobotEventTestEventBusMainThreadTest__Annotations$2() {
  return [IOSObjectArray arrayWithObjects:(id[]){ create_OrgJunitTest(OrgJunitTest_None_class_(), 0) } count:1 type:JavaLangAnnotationAnnotation_class_()];
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(DeGreenrobotEventTestEventBusMainThreadTest)

@implementation DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster

- (instancetype)initWithDeGreenrobotEventTestEventBusMainThreadTest:(DeGreenrobotEventTestEventBusMainThreadTest *)outer$ {
  DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_initWithDeGreenrobotEventTestEventBusMainThreadTest_(self, outer$);
  return self;
}

- (void)run {
  while (JreLoadVolatileBoolean(&running_)) {
    id event = DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_pollEvent(self);
    if (event != nil) {
      [((DeGreenrobotEventEventBus *) nil_chk(this$0_->eventBus_)) postWithId:event];
      @synchronized(eventsDone_) {
        [((id<JavaUtilList>) nil_chk(eventsDone_)) addWithId:event];
        [eventsDone_ java_notifyAll];
      }
    }
  }
}

- (id)pollEvent {
  return DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_pollEvent(self);
}

- (void)shutdown {
  JreAssignVolatileBoolean(&running_, false);
  @synchronized(eventQ_) {
    [((id<JavaUtilList>) nil_chk(eventQ_)) java_notifyAll];
  }
}

- (void)postWithId:(id)event {
  @synchronized(eventQ_) {
    [((id<JavaUtilList>) nil_chk(eventQ_)) addWithId:event];
    [eventQ_ java_notifyAll];
  }
  @synchronized(eventsDone_) {
    while ([((id<JavaUtilList>) nil_chk(eventsDone_)) removeWithId:event]) {
      @try {
        [eventsDone_ java_wait];
      }
      @catch (JavaLangInterruptedException *e) {
        @throw create_JavaLangRuntimeException_initWithNSException_(e);
      }
    }
  }
}

- (void)dealloc {
  RELEASE_(this$0_);
  RELEASE_(eventQ_);
  RELEASE_(eventsDone_);
  [super dealloc];
}

+ (const J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { NULL, NULL, 0x1, -1, -1, -1, -1, -1, -1 },
    { NULL, "V", 0x1, -1, -1, -1, -1, -1, -1 },
    { NULL, "LNSObject;", 0x22, -1, -1, -1, -1, -1, -1 },
    { NULL, "V", 0x0, -1, -1, -1, -1, -1, -1 },
    { NULL, "V", 0x0, 0, 1, -1, -1, -1, -1 },
  };
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wobjc-multiple-method-names"
  methods[0].selector = @selector(initWithDeGreenrobotEventTestEventBusMainThreadTest:);
  methods[1].selector = @selector(run);
  methods[2].selector = @selector(pollEvent);
  methods[3].selector = @selector(shutdown);
  methods[4].selector = @selector(postWithId:);
  #pragma clang diagnostic pop
  static const J2ObjcFieldInfo fields[] = {
    { "this$0_", "LDeGreenrobotEventTestEventBusMainThreadTest;", .constantValue.asLong = 0, 0x1012, -1, -1, -1, -1 },
    { "running_", "Z", .constantValue.asLong = 0, 0x40, -1, -1, -1, -1 },
    { "eventQ_", "LJavaUtilList;", .constantValue.asLong = 0, 0x12, -1, -1, 2, -1 },
    { "eventsDone_", "LJavaUtilList;", .constantValue.asLong = 0, 0x12, -1, -1, 2, -1 },
  };
  static const void *ptrTable[] = { "post", "LNSObject;", "Ljava/util/List<Ljava/lang/Object;>;", "LDeGreenrobotEventTestEventBusMainThreadTest;" };
  static const J2ObjcClassInfo _DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster = { "BackgroundPoster", "de.greenrobot.event.test", ptrTable, methods, fields, 7, 0x0, 5, 4, 3, -1, -1, -1, -1 };
  return &_DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster;
}

@end

void DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_initWithDeGreenrobotEventTestEventBusMainThreadTest_(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *self, DeGreenrobotEventTestEventBusMainThreadTest *outer$) {
  JreStrongAssign(&self->this$0_, outer$);
  JavaLangThread_initWithNSString_(self, @"BackgroundPoster");
  JreAssignVolatileBoolean(&self->running_, true);
  JreStrongAssignAndConsume(&self->eventQ_, new_JavaUtilArrayList_init());
  JreStrongAssignAndConsume(&self->eventsDone_, new_JavaUtilArrayList_init());
}

DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *new_DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_initWithDeGreenrobotEventTestEventBusMainThreadTest_(DeGreenrobotEventTestEventBusMainThreadTest *outer$) {
  J2OBJC_NEW_IMPL(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster, initWithDeGreenrobotEventTestEventBusMainThreadTest_, outer$)
}

DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *create_DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_initWithDeGreenrobotEventTestEventBusMainThreadTest_(DeGreenrobotEventTestEventBusMainThreadTest *outer$) {
  J2OBJC_CREATE_IMPL(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster, initWithDeGreenrobotEventTestEventBusMainThreadTest_, outer$)
}

id DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster_pollEvent(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster *self) {
  @synchronized(self) {
    id event = nil;
    @synchronized(self->eventQ_) {
      if ([((id<JavaUtilList>) nil_chk(self->eventQ_)) isEmpty]) {
        @try {
          [self->eventQ_ java_waitWithLong:1000];
        }
        @catch (JavaLangInterruptedException *e) {
        }
      }
      if (![self->eventQ_ isEmpty]) {
        event = [self->eventQ_ removeWithInt:0];
      }
    }
    return event;
  }
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(DeGreenrobotEventTestEventBusMainThreadTest_BackgroundPoster)