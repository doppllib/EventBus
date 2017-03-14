//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//

#include "AndroidOsHandler.h"
#include "AndroidOsLooper.h"
#include "AndroidOsMessage.h"
#include "DeGreenrobotEventEventBus.h"
#include "DeGreenrobotEventTestAbstractEventBusTest.h"
#include "IOSClass.h"
#include "IOSObjectArray.h"
#include "J2ObjC_source.h"
#include "java/lang/InterruptedException.h"
#include "java/lang/RuntimeException.h"
#include "java/lang/Thread.h"
#include "java/lang/annotation/Annotation.h"
#include "java/util/List.h"
#include "java/util/concurrent/CopyOnWriteArrayList.h"
#include "java/util/concurrent/CountDownLatch.h"
#include "java/util/concurrent/TimeUnit.h"
#include "java/util/concurrent/atomic/AtomicInteger.h"
#include "junit/framework/TestCase.h"
#include "org/junit/Before.h"

@interface DeGreenrobotEventTestAbstractEventBusTest () {
 @public
  DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *mainPoster_;
}

@end

J2OBJC_FIELD_SETTER(DeGreenrobotEventTestAbstractEventBusTest, mainPoster_, DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *)

__attribute__((unused)) static IOSObjectArray *DeGreenrobotEventTestAbstractEventBusTest__Annotations$0();

@interface DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler () {
 @public
  DeGreenrobotEventTestAbstractEventBusTest *this$0_;
}

@end

@implementation DeGreenrobotEventTestAbstractEventBusTest

J2OBJC_IGNORE_DESIGNATED_BEGIN
- (instancetype)init {
  DeGreenrobotEventTestAbstractEventBusTest_init(self);
  return self;
}
J2OBJC_IGNORE_DESIGNATED_END

- (instancetype)initWithBoolean:(jboolean)collectEventsReceived {
  DeGreenrobotEventTestAbstractEventBusTest_initWithBoolean_(self, collectEventsReceived);
  return self;
}

- (void)setUp {
  [super setUp];
  DeGreenrobotEventEventBus_clearCaches();
  JreStrongAssignAndConsume(&eventBus_, new_DeGreenrobotEventEventBus_init());
  JreStrongAssignAndConsume(&mainPoster_, new_DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler_initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_(self, AndroidOsLooper_getMainLooper()));
  JavaLangThread *currentThread = JavaLangThread_currentThread();
  JavaLangThread *looperThread = [((AndroidOsLooper *) nil_chk(AndroidOsLooper_getMainLooper())) getThread];
  jboolean threadsEqual = [((JavaLangThread *) nil_chk(looperThread)) isEqual:currentThread];
  JunitFrameworkTestCase_assertFalseWithBoolean_(threadsEqual);
}

- (void)postInMainThreadWithId:(id)event {
  [((DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *) nil_chk(mainPoster_)) postWithId:event];
}

- (void)waitForEventCountWithInt:(jint)expectedCount
                         withInt:(jint)maxMillis {
  for (jint i = 0; i < maxMillis; i++) {
    jint currentCount = [((JavaUtilConcurrentAtomicAtomicInteger *) nil_chk(eventCount_)) get];
    if (currentCount == expectedCount) {
      break;
    }
    else if (currentCount > expectedCount) {
      JunitFrameworkTestCase_failWithNSString_(JreStrcat("$I$IC", @"Current count (", currentCount, @") is already higher than expected count (", expectedCount, ')'));
    }
    else {
      @try {
        JavaLangThread_sleepWithLong_(1);
      }
      @catch (JavaLangInterruptedException *e) {
        @throw create_JavaLangRuntimeException_initWithNSException_(e);
      }
    }
  }
  JunitFrameworkTestCase_assertEqualsWithInt_withInt_(expectedCount, [((JavaUtilConcurrentAtomicAtomicInteger *) nil_chk(eventCount_)) get]);
}

- (void)trackEventWithId:(id)event {
  JreVolatileStrongAssign(&lastEvent_, event);
  JreVolatileStrongAssign(&lastThread_, JavaLangThread_currentThread());
  if (eventsReceived_ != nil) {
    [eventsReceived_ addWithId:event];
  }
  [((JavaUtilConcurrentAtomicAtomicInteger *) nil_chk(eventCount_)) incrementAndGet];
}

- (void)assertEventCountWithInt:(jint)expectedEventCount {
  JunitFrameworkTestCase_assertEqualsWithInt_withInt_(expectedEventCount, [((JavaUtilConcurrentAtomicAtomicInteger *) nil_chk(eventCount_)) intValue]);
}

- (void)countDownAndAwaitLatchWithJavaUtilConcurrentCountDownLatch:(JavaUtilConcurrentCountDownLatch *)latch
                                                          withLong:(jlong)seconds {
  [((JavaUtilConcurrentCountDownLatch *) nil_chk(latch)) countDown];
  [self awaitLatchWithJavaUtilConcurrentCountDownLatch:latch withLong:seconds];
}

- (void)awaitLatchWithJavaUtilConcurrentCountDownLatch:(JavaUtilConcurrentCountDownLatch *)latch
                                              withLong:(jlong)seconds {
  @try {
    JunitFrameworkTestCase_assertTrueWithBoolean_([((JavaUtilConcurrentCountDownLatch *) nil_chk(latch)) awaitWithLong:seconds withJavaUtilConcurrentTimeUnit:JreLoadEnum(JavaUtilConcurrentTimeUnit, SECONDS)]);
  }
  @catch (JavaLangInterruptedException *e) {
    @throw create_JavaLangRuntimeException_initWithNSException_(e);
  }
}

- (void)__javaClone:(DeGreenrobotEventTestAbstractEventBusTest *)original {
  [super __javaClone:original];
  JreCloneVolatileStrong(&lastEvent_, &original->lastEvent_);
  JreCloneVolatileStrong(&lastThread_, &original->lastThread_);
}

- (void)dealloc {
  RELEASE_(eventBus_);
  RELEASE_(eventCount_);
  RELEASE_(eventsReceived_);
  JreReleaseVolatile(&lastEvent_);
  JreReleaseVolatile(&lastThread_);
  RELEASE_(mainPoster_);
  [super dealloc];
}

+ (const J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { NULL, NULL, 0x1, -1, -1, -1, -1, -1, -1 },
    { NULL, NULL, 0x1, -1, 0, -1, -1, -1, -1 },
    { NULL, "V", 0x1, -1, -1, 1, -1, 2, -1 },
    { NULL, "V", 0x4, 3, 4, -1, -1, -1, -1 },
    { NULL, "V", 0x4, 5, 6, -1, -1, -1, -1 },
    { NULL, "V", 0x4, 7, 4, -1, -1, -1, -1 },
    { NULL, "V", 0x4, 8, 9, -1, -1, -1, -1 },
    { NULL, "V", 0x4, 10, 11, -1, -1, -1, -1 },
    { NULL, "V", 0x4, 12, 11, -1, -1, -1, -1 },
  };
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wobjc-multiple-method-names"
  methods[0].selector = @selector(init);
  methods[1].selector = @selector(initWithBoolean:);
  methods[2].selector = @selector(setUp);
  methods[3].selector = @selector(postInMainThreadWithId:);
  methods[4].selector = @selector(waitForEventCountWithInt:withInt:);
  methods[5].selector = @selector(trackEventWithId:);
  methods[6].selector = @selector(assertEventCountWithInt:);
  methods[7].selector = @selector(countDownAndAwaitLatchWithJavaUtilConcurrentCountDownLatch:withLong:);
  methods[8].selector = @selector(awaitLatchWithJavaUtilConcurrentCountDownLatch:withLong:);
  #pragma clang diagnostic pop
  static const J2ObjcFieldInfo fields[] = {
    { "LONG_TESTS", "Z", .constantValue.asBOOL = DeGreenrobotEventTestAbstractEventBusTest_LONG_TESTS, 0x1c, -1, -1, -1, -1 },
    { "eventBus_", "LDeGreenrobotEventEventBus;", .constantValue.asLong = 0, 0x4, -1, -1, -1, -1 },
    { "eventCount_", "LJavaUtilConcurrentAtomicAtomicInteger;", .constantValue.asLong = 0, 0x14, -1, -1, -1, -1 },
    { "eventsReceived_", "LJavaUtilList;", .constantValue.asLong = 0, 0x14, -1, -1, 13, -1 },
    { "lastEvent_", "LNSObject;", .constantValue.asLong = 0, 0x44, -1, -1, -1, -1 },
    { "lastThread_", "LJavaLangThread;", .constantValue.asLong = 0, 0x44, -1, -1, -1, -1 },
    { "mainPoster_", "LDeGreenrobotEventTestAbstractEventBusTest_EventPostHandler;", .constantValue.asLong = 0, 0x2, -1, -1, -1, -1 },
  };
  static const void *ptrTable[] = { "Z", "LJavaLangException;", (void *)&DeGreenrobotEventTestAbstractEventBusTest__Annotations$0, "postInMainThread", "LNSObject;", "waitForEventCount", "II", "trackEvent", "assertEventCount", "I", "countDownAndAwaitLatch", "LJavaUtilConcurrentCountDownLatch;J", "awaitLatch", "Ljava/util/List<Ljava/lang/Object;>;", "LDeGreenrobotEventTestAbstractEventBusTest_EventPostHandler;" };
  static const J2ObjcClassInfo _DeGreenrobotEventTestAbstractEventBusTest = { "AbstractEventBusTest", "de.greenrobot.event.test", ptrTable, methods, fields, 7, 0x401, 9, 7, -1, 14, -1, -1, -1 };
  return &_DeGreenrobotEventTestAbstractEventBusTest;
}

@end

void DeGreenrobotEventTestAbstractEventBusTest_init(DeGreenrobotEventTestAbstractEventBusTest *self) {
  DeGreenrobotEventTestAbstractEventBusTest_initWithBoolean_(self, false);
}

void DeGreenrobotEventTestAbstractEventBusTest_initWithBoolean_(DeGreenrobotEventTestAbstractEventBusTest *self, jboolean collectEventsReceived) {
  JunitFrameworkTestCase_init(self);
  JreStrongAssignAndConsume(&self->eventCount_, new_JavaUtilConcurrentAtomicAtomicInteger_init());
  if (collectEventsReceived) {
    JreStrongAssignAndConsume(&self->eventsReceived_, new_JavaUtilConcurrentCopyOnWriteArrayList_init());
  }
  else {
    JreStrongAssign(&self->eventsReceived_, nil);
  }
}

IOSObjectArray *DeGreenrobotEventTestAbstractEventBusTest__Annotations$0() {
  return [IOSObjectArray arrayWithObjects:(id[]){ create_OrgJunitBefore() } count:1 type:JavaLangAnnotationAnnotation_class_()];
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(DeGreenrobotEventTestAbstractEventBusTest)

@implementation DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler

- (instancetype)initWithDeGreenrobotEventTestAbstractEventBusTest:(DeGreenrobotEventTestAbstractEventBusTest *)outer$
                                              withAndroidOsLooper:(AndroidOsLooper *)looper {
  DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler_initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_(self, outer$, looper);
  return self;
}

- (void)handleMessageWithAndroidOsMessage:(AndroidOsMessage *)msg {
  [((DeGreenrobotEventEventBus *) nil_chk(this$0_->eventBus_)) postWithId:((AndroidOsMessage *) nil_chk(msg))->obj_];
}

- (void)postWithId:(id)event {
  [self sendMessageWithAndroidOsMessage:[self obtainMessageWithInt:0 withId:event]];
}

- (void)dealloc {
  RELEASE_(this$0_);
  [super dealloc];
}

+ (const J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { NULL, NULL, 0x1, -1, 0, -1, -1, -1, -1 },
    { NULL, "V", 0x1, 1, 2, -1, -1, -1, -1 },
    { NULL, "V", 0x0, 3, 4, -1, -1, -1, -1 },
  };
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wobjc-multiple-method-names"
  methods[0].selector = @selector(initWithDeGreenrobotEventTestAbstractEventBusTest:withAndroidOsLooper:);
  methods[1].selector = @selector(handleMessageWithAndroidOsMessage:);
  methods[2].selector = @selector(postWithId:);
  #pragma clang diagnostic pop
  static const J2ObjcFieldInfo fields[] = {
    { "this$0_", "LDeGreenrobotEventTestAbstractEventBusTest;", .constantValue.asLong = 0, 0x1012, -1, -1, -1, -1 },
  };
  static const void *ptrTable[] = { "LAndroidOsLooper;", "handleMessage", "LAndroidOsMessage;", "post", "LNSObject;", "LDeGreenrobotEventTestAbstractEventBusTest;" };
  static const J2ObjcClassInfo _DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler = { "EventPostHandler", "de.greenrobot.event.test", ptrTable, methods, fields, 7, 0x0, 3, 1, 5, -1, -1, -1, -1 };
  return &_DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler;
}

@end

void DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler_initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_(DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *self, DeGreenrobotEventTestAbstractEventBusTest *outer$, AndroidOsLooper *looper) {
  JreStrongAssign(&self->this$0_, outer$);
  AndroidOsHandler_initWithAndroidOsLooper_(self, looper);
}

DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *new_DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler_initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_(DeGreenrobotEventTestAbstractEventBusTest *outer$, AndroidOsLooper *looper) {
  J2OBJC_NEW_IMPL(DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler, initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_, outer$, looper)
}

DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler *create_DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler_initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_(DeGreenrobotEventTestAbstractEventBusTest *outer$, AndroidOsLooper *looper) {
  J2OBJC_CREATE_IMPL(DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler, initWithDeGreenrobotEventTestAbstractEventBusTest_withAndroidOsLooper_, outer$, looper)
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(DeGreenrobotEventTestAbstractEventBusTest_EventPostHandler)