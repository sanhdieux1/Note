package com.khoa.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AccessActivityData {

    private String userCode;

    private String brandName;

    private String functionName;

    private String functionParams;

    private String description;

    private long accessTime;

    private String initGroupName;

    public String getTruncatedFunctionName() {
        return functionName;
    }

}
