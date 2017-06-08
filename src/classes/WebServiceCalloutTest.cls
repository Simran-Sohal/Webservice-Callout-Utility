/** 
 * Copyright (c) 2017 Simranjeet Singh
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/
@isTest(seeAllData=false)
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
