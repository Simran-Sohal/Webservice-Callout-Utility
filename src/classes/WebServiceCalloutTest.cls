/*
 * Copyright (c) 2016 Financial Spectra
 * All rights reserved.
 * 
 * Class Name   - WebServiceCalloutTest
 *
 * Description  - Test class for WebServiceCalloutBuilder
 *                and WebServiceCalloutGateway
 *
 * Developer(s) - SSingh
 */
@isTest
private class WebServiceCalloutTest{

    @isTest
    private static void testWebServiceCalloutBuilder(){
        Test.startTest();
        
        WebServiceCalloutBuilder wsBuilder = new WebServiceCalloutBuilder()
                                                    .setHostURL('http://login.salesforce.com')
                                                    .setHostURI('/services/data/v36.0/tooling/sobjects/ApexClass')
                                                    .setHeaderParam('Content-Type', 'application/json')
                                                    .setURLParam('id','01p37000002Nzcy')
                                                    .setRequestMethod('GET')
                                                    .setRequestBody('')
                                                    .setTimeOut(30000);
        
        String endPoint = wsBuilder.getEndPoint();
        System.assertEquals('http://login.salesforce.com/services/data/v36.0/tooling/sobjects/ApexClass?id=01p37000002Nzcy', endPoint, 'End point assert');

        String requestMethod = wsBuilder.getRequestMethod();
        System.assertEquals('GET', requestMethod, 'Request Method assert');

        String requestBody = wsBuilder.getRequestBody();
        System.assertEquals('', requestBody, 'Request Body assert');

        Integer timeOut = wsBuilder.getTimeOut();
        System.assertEquals(30000, timeOut, 'Time out assert');
        
        Map<String, String> headerMap = wsBuilder.getHeaderParams();
        System.assertEquals(1, headerMap.size(), 'Header param size assert');
        
        Test.stopTest();
    }

    @isTest
    private static void testWebServiceCalloutGateway(){
        Test.startTest();
        
        WebServiceCalloutBuilder wsBuilder = new WebServiceCalloutBuilder()
                                                    .setHostURL('http://login.salesforce.com')
                                                    .setHostURI('/services/data/v36.0/tooling/sobjects/ApexClass')
                                                    .setHeaderParam('Content-Type', 'application/json')
                                                    .setURLParam('id','01p37000002Nzcy')
                                                    .setRequestMethod('GET')
                                                    .setRequestBody('')
                                                    .setTimeOut(30000);
        
        WebServiceCalloutGateway wsGateway = new WebServiceCalloutGateway(wsBuilder);
        HttpResponse response = wsGateway.sendRequest();
        
        System.assertEquals('OK', response.getStatus(), 'Response status assert');
        System.assertEquals(200, response.getStatusCode(), 'Response status code assert');
        System.assertEquals('{ "response" : "test" }', response.getBody(), 'Response body assert');
        Test.stopTest();
    }

}