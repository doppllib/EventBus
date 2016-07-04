/*
 * Copyright (C) 2013 Markus Junginger, greenrobot (http://greenrobot.de)
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
import de.greenrobot.event.EventBusException;

/**
 * @author Markus Junginger, greenrobot
 */
@DoppelTest
@RunWith(DopplSkipJavaJUnit4ClassRunner.class)
public class EventBusSubscriberLegalTest extends AbstractEventBusTest {

    @Test
    public void testSubscriberLegal() {
        eventBus.register(this);
        eventBus.post("42");
        eventBus.unregister(this);
        assertEquals(1, eventCount.intValue());
    }

    @Test
    public void testSubscriberNotPublic() {
        try {
            eventBus.register(new NotPublic());
            fail("Registration of ilegal subscriber successful");
        } catch (EventBusException e) {
            // Expected
        }
    }

    @Test
    public void testSubscriberStatic() {
        try {
            eventBus.register(new Static());
            fail("Registration of ilegal subscriber successful");
        } catch (EventBusException e) {
            // Expected
        }
    }

    @Test
    public void testSubscriberLegalAbstract() {
        eventBus.register(new Abstract() {

            @Override
            public void onEvent(String event) {
                trackEvent(event);
            }

        });

        eventBus.post("42");
        assertEquals(1, eventCount.intValue());
    }

    public void onEvent(String event) {
        trackEvent(event);
    }

    static class NotPublic {
        void onEvent(String event) {
        }
    }

    static abstract class Abstract {
        public abstract void onEvent(String event);
    }

    static class Static {
        public static void onEvent(String event) {
        }
    }

}