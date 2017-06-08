/*
 * Copyright (c) 2016 Financial Spectra
 * All rights reserved.
 * 
 * Class Name   - WebServiceCalloutBuilder
 *
 * Description  - This class is constructs the object with the parameters
 *                required for invoking an external web service 
 *
 * Developer(s) - SSingh
 */  
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