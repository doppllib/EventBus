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

import org.junit.Test;
import org.junit.runner.RunWith;

import co.touchlab.doppel.testing.DoppelTest;
import co.touchlab.doppel.testing.DopplSkipJavaJUnit4ClassRunner;

/**
 * @author Markus Junginger, greenrobot
 */
@DoppelTest
@RunWith(DopplSkipJavaJUnit4ClassRunner.class)
public class EventBusStickyEventTest extends AbstractEventBusTest {

    @Test
    public void testPostSticky() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.registerSticky(this);
        assertEquals("Sticky", lastEvent);
        assertEquals(Thread.currentThread(), lastThread);
    }

    @Test
    public void testPostStickyTwoEvents() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.postSticky(new IntTestEvent(7));
        eventBus.registerSticky(this);
        assertEquals(2, eventCount.intValue());
    }

    @Test
    public void testPostStickyRegisterNonSticky() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.register(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
    }

    @Test
    public void testPostNonStickyRegisterSticky() throws InterruptedException {
        eventBus.post("NonSticky");
        eventBus.registerSticky(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
    }

    @Test
    public void testPostStickyTwice() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.postSticky("NewSticky");
        eventBus.registerSticky(this);
        assertEquals("NewSticky", lastEvent);
    }

    @Test
    public void testPostStickyThenPostNormal() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.post("NonSticky");
        eventBus.registerSticky(this);
        assertEquals("Sticky", lastEvent);
    }

    @Test
    public void testPostStickyWithRegisterAndUnregister() throws InterruptedException {
        eventBus.registerSticky(this);
        eventBus.postSticky("Sticky");
        assertEquals("Sticky", lastEvent);

        eventBus.unregister(this);
        eventBus.registerSticky(this);
        assertEquals("Sticky", lastEvent);
        assertEquals(2, eventCount.intValue());

        eventBus.postSticky("NewSticky");
        assertEquals(3, eventCount.intValue());
        assertEquals("NewSticky", lastEvent);

        eventBus.unregister(this);
        eventBus.registerSticky(this);
        assertEquals(4, eventCount.intValue());
        assertEquals("NewSticky", lastEvent);
    }

    @Test
    public void testPostStickyAndGet() throws InterruptedException {
        eventBus.postSticky("Sticky");
        assertEquals("Sticky", eventBus.getStickyEvent(String.class));
    }

    @Test
    public void testPostStickyRemoveClass() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.removeStickyEvent(String.class);
        assertNull(eventBus.getStickyEvent(String.class));
        eventBus.registerSticky(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
    }

    @Test
    public void testPostStickyRemoveEvent() throws InterruptedException {
        eventBus.postSticky("Sticky");
        assertTrue(eventBus.removeStickyEvent("Sticky"));
        assertNull(eventBus.getStickyEvent(String.class));
        eventBus.registerSticky(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
    }

    @Test
    public void testPostStickyRemoveAll() throws InterruptedException {
        eventBus.postSticky("Sticky");
        eventBus.postSticky(new IntTestEvent(77));
        eventBus.removeAllStickyEvents();
        assertNull(eventBus.getStickyEvent(String.class));
        assertNull(eventBus.getStickyEvent(IntTestEvent.class));
        eventBus.registerSticky(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
    }

    @Test
    public void testRemoveStickyEventInSubscriber() throws InterruptedException {
        eventBus.registerSticky(new Object() {
            @SuppressWarnings("unused")
            public void onEvent(String event) {
                eventBus.removeStickyEvent(event);
            }
        });
        eventBus.postSticky("Sticky");
        eventBus.registerSticky(this);
        assertNull(lastEvent);
        assertEquals(0, eventCount.intValue());
        assertNull(eventBus.getStickyEvent(String.class));
    }

    public void onEvent(String event) {
        trackEvent(event);
    }

    public void onEvent(IntTestEvent event) {
        trackEvent(event);
    }

}
