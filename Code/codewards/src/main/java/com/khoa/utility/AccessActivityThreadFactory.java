package com.khoa.utility;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ThreadFactory;

public class AccessActivityThreadFactory implements ThreadFactory {
    private int counter;
    private final String name;
    private final List<String> stats;

    public AccessActivityThreadFactory(String name1) {
        counter = 1;
        this.name = name1;
        stats = new ArrayList<>();
    }

    @Override
    public Thread newThread(Runnable runnable) {
        Thread t = new Thread(runnable, String.format("%s_%s", name, counter));
        counter++;
        stats.add(String.format("Created thread %d with name %s on %s %n", t.getId(), t.getName(), new Date()));
        return t;
    }

    public String getStats() {
        StringBuilder buffer = new StringBuilder();
        Iterator<String> it = stats.iterator();
        while (it.hasNext()) {
            buffer.append(it.next());
        }
        return buffer.toString();
    }
}
