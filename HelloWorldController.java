package com.websystique.springmvc.controller;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping(value = { "/", "/*", "/**" })
public class HelloWorldController {
    public static final String REST_SERVICE_URI = "http://localhost:8080/Spring4MVCHelloWorldDemo";

    private static HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
        return headers;
    }

    @RequestMapping(method = RequestMethod.GET)
    public String sayHello(HttpServletRequest req, HttpServletResponse res) {
        RestTemplate restTemplate = new RestTemplate();
        HttpEntity<String> request = new HttpEntity<String>(getHeaders());
        ResponseEntity<String> response = restTemplate.exchange(
                REST_SERVICE_URI + "/welcome/sayhello/", HttpMethod.GET, request, String.class);
        String user = response.getBody();
        System.out.println(user);
        return "welcome";
    }

    private void forwardRequest(String method, HttpServletRequest req, HttpServletResponse resp) {
        final boolean hasoutbody = (method.equals("POST"));

        try {
            final URL url = new URL(REST_SERVICE_URI // no trailing slash
                    + req.getRequestURI()
                    + (req.getQueryString() != null ? "?" + req.getQueryString() : ""));
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod(method);

            final Enumeration<String> headers = req.getHeaderNames();
            while (headers.hasMoreElements()) {
                final String header = headers.nextElement();
                final Enumeration<String> values = req.getHeaders(header);
                while (values.hasMoreElements()) {
                    final String value = values.nextElement();
                    conn.addRequestProperty(header, value);
                }
            }

            // conn.setFollowRedirects(false); // throws AccessDenied exception
            conn.setUseCaches(false);
            conn.setDoInput(true);
            conn.setDoOutput(hasoutbody);
            conn.connect();

            final byte[] buffer = new byte[16384];
            while (hasoutbody) {
                final int read = req.getInputStream().read(buffer);
                if (read <= 0)
                    break;
                conn.getOutputStream().write(buffer, 0, read);
            }

            resp.setStatus(conn.getResponseCode());
            for (int i = 0;; ++i) {
                final String header = conn.getHeaderFieldKey(i);
                if (header == null)
                    break;
                final String value = conn.getHeaderField(i);
                resp.setHeader(header, value);
            }

            while (true) {
                final int read = conn.getInputStream().read(buffer);
                if (read <= 0)
                    break;
                resp.getOutputStream().write(buffer, 0, read);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // pass
        }
        // @RequestMapping(value = "/helloagain", method = RequestMethod.GET)
        // public String sayHelloAgain(ModelMap model) {
        // model.addAttribute("greeting", "Hello World Again, from Spring 4 MVC");
        // return "welcome";
        // }
    }
}