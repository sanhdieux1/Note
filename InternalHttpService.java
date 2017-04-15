package com.khoa.SpringRestTemplate;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.fasterxml.jackson.databind.util.JSONPObject;

public class InternalHttpService {
    private static RestTemplate restTemplate = new RestTemplate();
    public static ObjectMapper mapper = new ObjectMapper();
    public static <T> T getRequest(String url, Map<String, Object> params, Class<T> responseType) {
        UriComponentsBuilder uri = UriComponentsBuilder.fromUriString(url);
        if (params != null && !params.isEmpty()) {
            params.forEach((key, value) -> uri.queryParam(key, value));
        }
        return restTemplate.getForObject(uri.build().toUri(), responseType);
    }

    public static <T> T postRequestBody(String url, Object object, Class<T> responseType) {
        return restTemplate.postForObject(url, object, responseType);
    }

    public static <T> T postRequestBodyWithJson(String url, String json, Class<T> responseClass) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<String>(json, headers);
        ResponseEntity<T> result = restTemplate.postForEntity(url, entity, responseClass);
        if (result.hasBody()) {
            return result.getBody();
        }
        return null;
    }

    public static <T> T postRequestPart(String url, Map<String, Object> params,
            Class<T> responseType) {
        MultiValueMap<String, HttpEntity<Object>> multiValueParts = new LinkedMultiValueMap<String, HttpEntity<Object>>();
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);
        if (params != null && !params.isEmpty()) {
            params.forEach((key, value) -> {
                HttpEntity<Object> entity = new HttpEntity<Object>(value, header);
                multiValueParts.add(key, entity);
            });
        }
        ResponseEntity<T> result = restTemplate.postForEntity(url, multiValueParts, responseType);
        if (result.hasBody()) {
            return result.getBody();
        }
        return null;
    }

    public static <T> T postRequestParams(String url, Map<String, Object> parts,
            Class<T> responseType) {
        return postRequestPart(url, parts, responseType);
    }
    
    public static <T> T postRequestSingle(String url, Map<String, Object> parts,
            Class<T> responseType) {
        
        HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.APPLICATION_JSON);
        
        ObjectNode objNode = mapper.createObjectNode();
        objNode.put("name", "kail");
        objNode.put("age", "10");
        String json = objNode.asText();
        System.out.println(json);
        HttpEntity<String> entity = new HttpEntity<String>(json, header);
         ResponseEntity<T> result = restTemplate.postForEntity(url, entity, responseType);
        
        return result.getBody();
    }

}
