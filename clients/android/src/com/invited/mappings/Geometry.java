package com.invited.mappings;

import android.os.Parcel;
import android.os.Parcelable;

public class Geometry implements Parcelable {
	public Location location;

	public int describeContents() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void writeToParcel(Parcel dest, int flags) {
		// TODO Auto-generated method stub
		dest.writeParcelable(location, 0);
		
	}
	
	public Geometry(Parcel in)
	{
		location = in.readParcelable(null);
	}
	
	 public static final Parcelable.Creator CREATOR =
	    	new Parcelable.Creator() {
	            public Geometry createFromParcel(Parcel in) {
	                return new Geometry(in);
	            }
	 
	            public Geometry[] newArray(int size) {
	                return new Geometry[size];
	            }
	        };
}
