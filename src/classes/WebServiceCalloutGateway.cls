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
