package com.invited.sessions;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Base64;

import com.github.droidfu.http.BetterHttp;
import com.github.droidfu.http.BetterHttpRequest;
import com.github.droidfu.http.BetterHttpResponse;

public class Authenticated extends com.invited.InvitedApplication {
//	public Context context = getApplicationContext();
	
	static {
		BetterHttp.setDefaultHeader("User-Agent", "Android");
		BetterHttp.setDefaultHeader("Authorization", "Basic " + (String)Base64.encodeToString(("test:").getBytes(), Base64.DEFAULT));
		BetterHttp.setDefaultHeader("Accept", "application/json");
		session();
	}
	
	/**
	 * Once you get out of this method, you should always have an authenticated session
	 * If you don't, you should consider what to do otherwise with the application
	 * 
	 */
	public static void session() {
		if (BetterHttp.getHttpClient()==null){
			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
			BetterHttpRequest request;
			BetterHttpResponse response;

			// Refactor here to remove the device_id and app_token to get them out of Application context
			// http://mobile.tutsplus.com/tutorials/android/android-application-preferences/
			nameValuePairs.add(new BasicNameValuePair("device_id", "easycheesy1"));
			nameValuePairs.add(new BasicNameValuePair("app_token", "4de9eed1fe4e44963a30d9763b17f6fb"));
			
			try {
				request = BetterHttp.post("http://jancel.doesntexist.com:3000/device_session",new UrlEncodedFormEntity(nameValuePairs));
				response = request.send();
				
				if (response.getResponseBodyAsString().contains("success")){
					// authenticated
				} else {
					// throw new Exception();
				}
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ConnectException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
