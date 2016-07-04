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
import de.greenrobot.event.EventBus;
import de.greenrobot.event.NoSubscriberEvent;
import de.greenrobot.event.SubscriberExceptionEvent;

/**
 * @author Markus Junginger, greenrobot
 */
@DoppelTest
@RunWith(DopplSkipJavaJUnit4ClassRunner.class)
public class EventBusNoSubscriberEventTest extends AbstractEventBusTest {


    @Test
    public void testNoSubscriberEvent() {
        eventBus.register(this);
        eventBus.post("Foo");
        assertEventCount(1);
        assertEquals(NoSubscriberEvent.class, lastEvent.getClass());
        NoSubscriberEvent noSub = (NoSubscriberEvent) lastEvent;
        assertEquals("Foo", noSub.originalEvent);
        assertSame(eventBus, noSub.eventBus);
    }

    @Test
    public void testNoSubscriberEventAfterUnregister() {
        Object subscriber = new Object() {
            @SuppressWarnings("unused")
            public void onEvent(String dummy) {
            }
        };
        eventBus.register(subscriber);
        eventBus.unregister(subscriber);
        testNoSubscriberEvent();
    }


    public void testBadNoSubscriberSubscriber() {
        eventBus = EventBus.builder().logNoSubscriberMessages(false).build();
        eventBus.register(this);
        eventBus.register(new BadNoSubscriberSubscriber());
        eventBus.post("Foo");
        assertEventCount(2);

        assertEquals(SubscriberExceptionEvent.class, lastEvent.getClass());
        NoSubscriberEvent noSub = (NoSubscriberEvent) ((SubscriberExceptionEvent) lastEvent).causingEvent;
        assertEquals("Foo", noSub.originalEvent);
    }

    public void onEvent(NoSubscriberEvent event) {
        trackEvent(event);
    }

    public void onEvent(SubscriberExceptionEvent event) {
        trackEvent(event);
    }

    class BadNoSubscriberSubscriber {
        public void onEvent(NoSubscriberEvent event) {
            throw new RuntimeException("I'm bad");
        }
    }

}
