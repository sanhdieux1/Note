package com.khoa.api;

import com.googlecode.jsonrpc4j.JsonRpcParam;
import com.googlecode.jsonrpc4j.JsonRpcService;
import com.khoa.model.AccessActivityData;

@JsonRpcService("/logger/api.json")
public interface AccessActivityLoggingService {
    void logAccessActivity(@JsonRpcParam("logdata") AccessActivityData logdata);
}
