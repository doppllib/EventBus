/*
 * Copyright (C) 2012 Markus Junginger, greenrobot (http://greenrobot.de)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package de.greenrobot.event.test;

import android.content.IOSContext;
import android.util.Log;

import junit.framework.TestCase;

import org.junit.Before;
import org.junit.Test;

import java.lang.ref.WeakReference;

import co.touchlab.doppl.testing.DopplHacks;
import co.touchlab.doppl.utils.PlatformUtils;
import de.greenrobot.event.EventBus;

/**
 * @author Markus Junginger, greenrobot
 */
import co.touchlab.doppl.testing.DopplTest;
@DopplTest
public class EventBusBasicTest extends TestCase {

    private EventBus eventBus;
    private String lastStringEvent;
    private int countStringEvent;
    private int countIntEvent;
    private int lastIntEvent;
    private int countMyEventExtended;
    private int countMyEvent;

    @Before
    public void setUp() throws Exception {
        super.setUp();
        eventBus = new EventBus();
    }

    @Test
    public void testRegisterAndPost() {
        // Use an activity to test real life performance
        TestActivity testActivity = new TestActivity();
        String event = "Hello";

        long start = System.currentTimeMillis();
        eventBus.register(testActivity);
        long time = System.currentTimeMillis() - start;
        Log.d(EventBus.TAG, "Registered in " + time + "ms");

        eventBus.post(event);

        assertEquals(event, testActivity.lastStringEvent);
    }

    @Test
    public void testPostWithoutSubscriber() {
        eventBus.post("Hello");
    }

    @Test
    public void testUnregisterWithoutRegister() {
        // Results in a warning without throwing
        eventBus.unregister(this);
    }

    @DopplHacks //Not sure how to test weak reference in j2objc
    public void testUnregisterNotLeaking() {
        if(PlatformUtils.isJ2objc())
            return;
        EventBusBasicTest subscriber = new EventBusBasicTest();
        eventBus.register(subscriber);
        eventBus.unregister(subscriber);

        WeakReference<EventBusBasicTest> ref = new WeakReference<EventBusBasicTest>(subscriber);
        subscriber = null;
        assertSubscriberNotReferenced(ref);
    }

    private void assertSubscriberNotReferenced(WeakReference<EventBusBasicTest> ref) {
        EventBusBasicTest subscriberTest = new EventBusBasicTest();
        WeakReference<EventBusBasicTest> refTest = new WeakReference<EventBusBasicTest>(subscriberTest);
        subscriberTest = null;

        // Yeah, in theory is is questionable (in practice just fine so far...)
        System.gc();

        assertNull(refTest.get());
        assertNull(ref.get());
    }

    @Test
    public void testRegisterTwice() {
        eventBus.register(this);
        try {
            eventBus.register(this);
            fail("Did not throw");
        } catch (RuntimeException expected) {
            // OK
        }
    }

    @Test
    public void testIsRegistered() {
        assertFalse(eventBus.isRegistered(this));
        eventBus.register(this);
        assertTrue(eventBus.isRegistered(this));
        eventBus.unregister(this);
        assertFalse(eventBus.isRegistered(this));
    }

    @Test
    public void testPostWithTwoSubscriber() {
        EventBusBasicTest test2 = new EventBusBasicTest();
        eventBus.register(this);
        eventBus.register(test2);
        String event = "Hello";
        eventBus.post(event);
        assertEquals(event, lastStringEvent);
        assertEquals(event, test2.lastStringEvent);
    }

    @Test
    public void testPostMultipleTimes() {
        eventBus.register(this);
        MyEvent event = new MyEvent();
        int count = 1000;
        long start = System.currentTimeMillis();
        // Debug.startMethodTracing("testPostMultipleTimes" + count);
        for (int i = 0; i < count; i++) {
            eventBus.post(event);
        }
        // Debug.stopMethodTracing();
        long time = System.currentTimeMillis() - start;
        Log.d(EventBus.TAG, "Posted " + count + " events in " + time + "ms");
        assertEquals(count, countMyEvent);
    }

    @Test
    public void testPostAfterUnregister() {
        eventBus.register(this);
        eventBus.unregister(this);
        eventBus.post("Hello");
        assertNull(lastStringEvent);
    }

    @Test
    public void testRegisterAndPostTwoTypes() {
        eventBus.register(this);
        eventBus.post(42);
        eventBus.post("Hello");
        assertEquals(1, countIntEvent);
        assertEquals(1, countStringEvent);
        assertEquals(42, lastIntEvent);
        assertEquals("Hello", lastStringEvent);
    }

    @Test
    public void testRegisterUnregisterAndPostTwoTypes() {
        eventBus.register(this);
        eventBus.unregister(this);
        eventBus.post(42);
        eventBus.post("Hello");
        assertEquals(0, countIntEvent);
        assertEquals(0, lastIntEvent);
        assertEquals(0, countStringEvent);
    }

    @Test
    public void testPostOnDifferentEventBus() {
        eventBus.register(this);
        new EventBus().post("Hello");
        assertEquals(0, countStringEvent);
    }

    @Test
    public void testPostInEventHandler() {
        RepostInteger reposter = new RepostInteger();
        eventBus.register(reposter);
        eventBus.register(this);
        eventBus.post(1);
        assertEquals(10, countIntEvent);
        assertEquals(10, lastIntEvent);
        assertEquals(10, reposter.countEvent);
        assertEquals(10, reposter.lastEvent);
    }

    @Test
    public void testHasSubscriberForEvent() {
        assertFalse(eventBus.hasSubscriberForEvent(String.class));

        eventBus.register(this);
        assertTrue(eventBus.hasSubscriberForEvent(String.class));

        eventBus.unregister(this);
        assertFalse(eventBus.hasSubscriberForEvent(String.class));
    }

    @Test
    public void testHasSubscriberForEventSuperclass() {
        assertFalse(eventBus.hasSubscriberForEvent(String.class));

        Object subscriber = new Object() {
            public void onEvent(Object event) {
            }
        };
        eventBus.register(subscriber);
        assertTrue(eventBus.hasSubscriberForEvent(String.class));

        eventBus.unregister(subscriber);
        assertFalse(eventBus.hasSubscriberForEvent(String.class));
    }

    @Test
    public void testHasSubscriberForEventImplementedInterface() {
        if(PlatformUtils.isJ2objc())
            return;

        assertFalse(eventBus.hasSubscriberForEvent(String.class));

        Object subscriber = new Object() {
            public void onEvent(CharSequence event) {
            }
        };
        eventBus.register(subscriber);
        assertTrue(eventBus.hasSubscriberForEvent(CharSequence.class));
        assertTrue(eventBus.hasSubscriberForEvent(String.class));

        eventBus.unregister(subscriber);
        assertFalse(eventBus.hasSubscriberForEvent(CharSequence.class));
        assertFalse(eventBus.hasSubscriberForEvent(String.class));
    }

    public void onEvent(String event) {
        lastStringEvent = event;
        countStringEvent++;
    }

    public void onEvent(Integer event) {
        lastIntEvent = event;
        countIntEvent++;
    }

    public void onEvent(MyEvent event) {
        countMyEvent++;
    }

    public void onEvent(MyEventExtended event) {
        countMyEventExtended++;
    }

    static class TestActivity extends IOSContext {
        public String lastStringEvent;

        public void onEvent(String event) {
            lastStringEvent = event;
        }
    }

    class MyEvent {
    }

    class MyEventExtended extends MyEvent {
    }

    class RepostInteger {
        public int lastEvent;
        public int countEvent;

        public void onEvent(Integer event) {
            lastEvent = event;
            countEvent++;
            assertEquals(countEvent, event.intValue());

            if (event < 10) {
                int countIntEventBefore = countEvent;
                eventBus.post(event + 1);
                // All our post calls will just enqueue the event, so check count is unchanged
                assertEquals(countIntEventBefore, countIntEventBefore);
            }
        }
    }

}
