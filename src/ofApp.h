#pragma once

#include "ofxiOS.h"
#include "shapes.h"

class ofApp : public ofxiOSApp {

	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

        int nCurveVertices= 0;

        vector <Shapes> myShapes;
        float appIphoneScale;
        bool start = false;
        bool drag = false; 
   
    float sTreshold;
    float accx,accy;
    int trig;
    int startshake;
    int shake;
    int shakemaxnumber ;
    int timeofgesture;
    
    int r = ofRandom(0,255);
    int  b= ofRandom(0,255);
  int g = ofRandom(0,255);
    
  
    


};


