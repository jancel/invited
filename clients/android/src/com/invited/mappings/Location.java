package com.invited.mappings;

import android.os.Parcel;
import android.os.Parcelable;

public class Location implements Parcelable {
	public String lat;
	public String lng;
	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}
	public void writeToParcel(Parcel dest, int flags) {
		// TODO Auto-generated method stub
		dest.writeString(lat);
		dest.writeString(lng);
	}
	
	public Location(Parcel in)
	{
		lat = in.readString();
		lng = in.readString();
	}
	
	 public static final Parcelable.Creator CREATOR =
	    	new Parcelable.Creator() {
	            public Location createFromParcel(Parcel in) {
	                return new Location(in);
	            }
	 
	            public Location[] newArray(int size) {
	                return new Location[size];
	            }
	        };

}
