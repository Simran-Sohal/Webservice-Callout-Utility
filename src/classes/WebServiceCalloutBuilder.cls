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
global with sharing class WebServiceCalloutBuilder{

    private String mHostURL;
    private String mHostURI;
    private Map<String, String> mURLParamMap;
    private String mEndPoint;

    private Map<String, String> mHeaderParamMap;

    private String mRequestMethod;
    private String mRequestBody;

    private Integer mTimeOut;
    private final Integer MAX_TIME_OUT = 120000;
    
    global WebServiceCalloutBuilder(){
        mHostURL = Constants.BLANK_STRING;
        mHostURI = Constants.BLANK_STRING;
        mURLParamMap = new Map<String, String>();
        mHeaderParamMap = new Map<String, String>();
        mEndPoint = Constants.BLANK_STRING;

        mRequestMethod = Constants.BLANK_STRING;
        mRequestBody = Constants.BLANK_STRING;
        mTimeOut = MAX_TIME_OUT;
    }

    /*
     * Setters
     */
    global WebServiceCalloutBuilder setHostURL(String pHostURL){
        this.mHostURL = pHostURL;
        return this;
    }
    global WebServiceCalloutBuilder setHostURI(String pHostURI){
        this.mHostURI = pHostURI;
        return this;
    }
    global WebServiceCalloutBuilder setURLParam(String pKey, String pValue){
        this.mURLParamMap.put(pKey, pValue);
        return this;
    }
    global WebServiceCalloutBuilder setHeaderParam(String pKey, String pValue){
        this.mHeaderParamMap.put(pKey, pValue);
        return this;
    }
    global WebServiceCalloutBuilder setRequestMethod(String pRequestMethod){
        this.mRequestMethod = pRequestMethod;
        return this;
    }
    global WebServiceCalloutBuilder setRequestBody(String pRequestBody){
        this.mRequestBody = pRequestBody;
        return this;
    }
    global WebServiceCalloutBuilder setTimeOut(Integer pTimeOut){
        this.mTimeOut = pTimeOut;
        return this;
    }

    private void setEndPoint(){
        mEndPoint = mHostURL + mHostURI;
        
        if (mURLParamMap.size() > 0){
            mEndPoint += '?';
            for (String key : mURLParamMap.keySet()){
                mEndPoint += (key + '=' + mURLParamMap.get(key) + '&');
            }
            mEndPoint = mEndPoint.subString(0, mEndPoint.length() - 1); // remove the last &
            System.debug(loggingLevel.ERROR, 'End Point : ' + mEndPoint);
        }
    }

    global String getEndPoint(){
        setEndPoint();
        return mEndPoint;
    }
    global Map<String, String> getHeaderParams(){
        return mHeaderParamMap;
    }
    global String getRequestMethod(){
        return mRequestMethod;
    }
    global String getRequestBody(){
        return mRequestBody;
    }
    global Integer getTimeOut(){
        return mTimeOut;
    }

}
