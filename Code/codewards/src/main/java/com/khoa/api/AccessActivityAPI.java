package com.khoa.api;


import com.googlecode.jsonrpc4j.spring.AutoJsonRpcServiceImpl;
import com.khoa.model.AccessActivityData;
import com.khoa.utility.AccessActivityThreadFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@AutoJsonRpcServiceImpl
@Service
public class AccessActivityAPI implements AccessActivityLoggingService, InternalControlLoggingService {
    private static final Logger LOGGER = Logger.getLogger(AccessActivityAPI.class.getName());

    private static final int MAX_QUEUE_SIZE = 200000;

    private static final long DEFAULT_GROUP_ID = 1L;

    private Object creatingFunctionLock = new Object();

    private ConcurrentHashMap<String, Long> funcNameIdMap = new ConcurrentHashMap<>();

    private ExecutorService execService;

    @PostConstruct
    public void start() {
        funcNameIdMap.putAll(new HashMap<>());
        execService = new ThreadPoolExecutor(1, 2,
                0L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<Runnable>(MAX_QUEUE_SIZE),
                new AccessActivityThreadFactory("ProcessLogDataInQueue"));
        LOGGER.info("AccessActivityAPI has started");
    }

    @PreDestroy
    public void stop() {
        if (execService != null) {
            execService.shutdown();
        }
    }

    @Override
    public void logAccessActivity(AccessActivityData logdata) {
        if (logdata != null) {
            try {
                execService.submit(() -> {
                    try {
                        processLogData(logdata);
                    } catch (Exception ex) {
                        LOGGER.log(Level.WARNING, "Error in processing log data in queue", ex);
                    }
                });
            } catch (Exception ex) {
                LOGGER.log(Level.WARNING, ex.getMessage());
            }
        }
    }

    @Override
    public Map<String, Long> reloadFunctionNameIDMap() {
        LOGGER.log(Level.INFO, "Reloading the function map");
        synchronized (creatingFunctionLock) {
            funcNameIdMap.clear();
            funcNameIdMap.putAll(new HashMap<>());
            LOGGER.log(Level.INFO, "Reloading finished, Map's size is " + funcNameIdMap.size());
            return new HashMap<>(funcNameIdMap);
        }
    }

    private void processLogData(AccessActivityData logdata) {
        long funcId = getOrCreateFunctionIdByName(logdata);
        String brandName = logdata.getBrandName();
        LOGGER.log(Level.FINE, "call save log {0},{1},{2}", new Object[] {funcId, brandName, logdata.getAccessTime()});
        //todo
    }

    private long getOrCreateFunctionIdByName(AccessActivityData logdata) {
        String funcName = logdata.getTruncatedFunctionName();
        String description = logdata.getDescription();
        Long funcId = funcNameIdMap.get(funcName);

        if (funcId == null) {
            synchronized (creatingFunctionLock) {
                funcId = funcNameIdMap.get(funcName);

                if (funcId == null) {
                    long groupId = getOrCreateGroup(logdata.getInitGroupName());
                    funcId = createFunction(funcName, groupId, description);
                }
            }
        }

        return funcId;
    }

    private Long createFunction(String funcName, long groupId, String description) {
        Long funcId = 0L;
        try {
            LOGGER.log(Level.FINE,"creating function {0} in group {1} with description {2}", new Object[]{funcName, groupId, description});
            //todo
            funcNameIdMap.put(funcName, funcId);
        } catch (DuplicateKeyException e) {
            LOGGER.warning("Reload function names due to duplicate entry " + e.getMessage());
            reloadFunctionNameIDMap();
            funcId = funcNameIdMap.get(funcName);
        }
        return funcId;
    }

    private long getOrCreateGroup(String groupName) {
        //todo
        return 0L;
    }

}
