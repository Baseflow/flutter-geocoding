// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license.

package com.baseflow.geocoding;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.UUID;
import org.junit.Test;

public class InstanceManagerTest {
    @Test
    public void addDartCreatedInstance() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final UUID identifier = UUID.randomUUID();
        final Object object = new Object();
        instanceManager.addDartCreatedInstance(object, identifier);

        assertEquals(object, instanceManager.getInstance(identifier));
        assertEquals(identifier, instanceManager.getIdentifierForStrongReference(object));
        assertTrue(instanceManager.containsInstance(object));

        instanceManager.stopFinalizationListener();
    }

    @Test
    public void addHostCreatedInstance() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final Object object = new Object();
        UUID identifier = instanceManager.addHostCreatedInstance(object);

        assertNotNull(instanceManager.getInstance(identifier));
        assertEquals(object, instanceManager.getInstance(identifier));
        assertTrue(instanceManager.containsInstance(object));

        instanceManager.stopFinalizationListener();
    }

    @Test
    public void remove() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final UUID identifier = UUID.randomUUID();
        Object object = new Object();

        instanceManager.addDartCreatedInstance(object, identifier);

        assertEquals(object, instanceManager.remove(identifier));

        // To allow for object to be garbage collected.
        //noinspection UnusedAssignment
        object = null;

        Runtime.getRuntime().gc();

        assertNull(instanceManager.getInstance(identifier));

        instanceManager.stopFinalizationListener();
    }

    @Test
    public void clear() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final UUID identifier = UUID.randomUUID();
        final Object instance = new Object();

        instanceManager.addDartCreatedInstance(instance, identifier);
        assertTrue(instanceManager.containsInstance(instance));

        instanceManager.clear();
        assertFalse(instanceManager.containsInstance(instance));

        instanceManager.stopFinalizationListener();
    }

    @Test
    public void canAddSameObjectWithAddDartCreatedInstance() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final UUID firstIdentifier = UUID.randomUUID();
        final UUID secondIdentifier = UUID.randomUUID();
        final Object instance = new Object();

        instanceManager.addDartCreatedInstance(instance, firstIdentifier);
        instanceManager.addDartCreatedInstance(instance, secondIdentifier);

        assertTrue(instanceManager.containsInstance(instance));

        assertEquals(instanceManager.getInstance(firstIdentifier), instance);
        assertEquals(instanceManager.getInstance(secondIdentifier), instance);

        instanceManager.stopFinalizationListener();
    }

    @Test(expected = IllegalArgumentException.class)
    public void cannotAddSameObjectsWithAddHostCreatedInstance() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final Object instance = new Object();

        instanceManager.addHostCreatedInstance(instance);
        instanceManager.addHostCreatedInstance(instance);

        instanceManager.stopFinalizationListener();
    }

    @Test(expected = IllegalArgumentException.class)
    public void identifiersMustBeUnique() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});

        final UUID identifier = UUID.randomUUID();

        instanceManager.addDartCreatedInstance(new Object(), identifier);
        instanceManager.addDartCreatedInstance(new Object(), identifier);

        instanceManager.stopFinalizationListener();
    }

    @Test
    public void managerIsUsableWhileListenerHasStopped() {
        final InstanceManager instanceManager = InstanceManager.create(identifier -> {});
        instanceManager.stopFinalizationListener();

        final Object instance = new Object();
        final UUID identifier = UUID.randomUUID();

        instanceManager.addDartCreatedInstance(instance, identifier);
        assertEquals(instanceManager.getInstance(identifier), instance);
        assertEquals(instanceManager.getIdentifierForStrongReference(instance), identifier);
        assertTrue(instanceManager.containsInstance(instance));
    }
}