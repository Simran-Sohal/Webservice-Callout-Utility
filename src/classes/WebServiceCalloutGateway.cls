/*
 * Copyright (c) 2016 Financial Spectra
 * All rights reserved.
 * 
 * Class Name   - WebServiceCalloutGateway
 *
 * Description  - This class is used to invoke an external Web Service
 *                using the instance in WebServiceCalloutBuilder
 *
 * Developer(s) - SSingh
 */  
global with sharing class WebServiceCalloutGateway{

    private WebServiceCalloutBuilder mWSBuilder;
    private HttpRequest mRequest;

    global WebServiceCalloutGateway(WebServiceCalloutBuilder pWSBuilder){
        mWSBuilder = pWSBuilder;
        mRequest = new HttpRequest();
        setRequest();
    }

    private void setRequest(){
        mRequest.setEndpoint(mWSBuilder.getEndPoint());
        mRequest.setTimeout(mWSBuilder.getTimeout());
        mRequest.setMethod(mWSBuilder.getRequestMethod());
    
        Map<String, String> headerParamMap = mWSBuilder.getHeaderParams();
        for(String key : headerParamMap.keySet()) {
            mRequest.setHeader(key, headerParamMap.get(key));
        }
        
        String requestBody = mWSBuilder.getRequestBody();
        if (String.IsNotBlank(requestBody)){ mRequest.setBody(requestBody); }
    }

    global HttpResponse sendRequest() {
        Http httpInstance = new Http();
        
        if (Test.isRunningTest()) { return getTestResponse(); }

        HttpResponse response = httpInstance.send(mRequest);
        return response;
    }

    private HttpResponse getTestResponse() {
        HttpResponse testResponse = new HttpResponse();
        
        testResponse.setStatus('OK');
        testResponse.setStatusCode(200);
        testResponse.setBody('{ "response" : "test" }');
        return testResponse;
    }
}