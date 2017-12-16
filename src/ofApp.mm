#include "ofApp.h"
#include "shapes.h"


//--------------------------------------------------------------
void ofApp::setup(){
    ofxAccelerometer.setup();

    ofBackground(255,255,255);
    ofSetCircleResolution(100);
    
    //SHAKING GESTURE
    sTreshold = 1.6;
    trig=0;
    shake=0;
    shakemaxnumber = 1;
    timeofgesture = 500;
  
}

//--------------------------------------------------------------
void ofApp::update(){
    //SHAKING IF ITS SHAKING SHAKING

    accx=ofxAccelerometer.getForce().x;
    accy=ofxAccelerometer.getForce().y;
    
    if(accx<-sTreshold && trig ==0){
        trig = 1;
        startshake = ofGetElapsedTimeMillis();
    }
    if(accx>sTreshold && trig == 1){
        trig=2;
    }
    if(accx<-sTreshold && trig == 2){
        trig=3;
    }
    if(accx>sTreshold && trig == 3){
        trig=4;
    }
    if (trig==4) {
        shake++;
        trig=0;
    }
    if ((ofGetElapsedTimeMillis() - startshake) > timeofgesture) {
        trig=0; 
    }
    
    
    if (shake>shakemaxnumber) {
        shake=0;
        r = ofRandom(0,255);
        g = ofRandom(0,255);
        b = ofRandom(0,255);
        myShapes.clear();

        
    }
    
   

}

//--------------------------------------------------------------
void ofApp::draw(){
    
    //WHEN SHAKING SHAKING CHANGE BACKGROUND
    ofPushStyle();

    if (shake==0) {
        ofBackground(r, g, b, 50);
    }
  
    
    ofFill();
    ofSetColor(r,b,g, 150);
    ofBeginShape();

    for (int i = 0; i < myShapes.size(); i++){
        
      //  ofVertex(myShapes[i].sPoint.x,myShapes[i].sPoint.y);
      //  ofCurveVertex(myShapes[i].sPoint);
        
        if (i == 0){
            ofCurveVertex(myShapes[0].sPoint.x, myShapes[0].sPoint.y); // we need to duplicate 0 for the curve to start at point 0
            ofCurveVertex(myShapes[0].sPoint.x, myShapes[0].sPoint.y); // we need to duplicate 0 for the curve to start at point 0
        } else if (i == myShapes.size()-1){
            ofCurveVertex(myShapes[i].sPoint.x, myShapes[i].sPoint.y);
            ofCurveVertex(myShapes[0].sPoint.x, myShapes[0].sPoint.y);    // to draw a curve from pt 6 to pt 0
            ofCurveVertex(myShapes[0].sPoint.x, myShapes[0].sPoint.y);    // we duplicate the first point twice
        } else {
            ofCurveVertex(myShapes[i].sPoint.x, myShapes[i].sPoint.y);
        }
    }
        

     ofEndShape();

    for (int i = 0; i < myShapes.size(); i++){
          ofSetColor(b,r,g,100);
          myShapes[i].draw();
       
 
    }





}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    
    if( touch.id == 0){
        for (int i = 0; i < myShapes.size(); i++){
            float diffx = touch.x/myShapes[i].sPoint.x;
            float diffy = touch.y/myShapes[i].sPoint.y;
            float dist = sqrt(diffx*diffx + diffy*diffy);
            if (dist < 45 ){
                myShapes[i].curveVertices.bBeingDragged     = true;
        
            } else {
               myShapes[i].curveVertices.bBeingDragged    = false;
            }
        }
    }

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

    
        for (int i = 0; i < myShapes.size(); i++){
            // Check if touch is inside the shape
            myShapes[i].handleTouch(touch);
       
        
    }
   
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
    if( touch.id == 0 ){
        for (int i = 0; i < myShapes.size(); i++){
           myShapes[i].curveVertices.bBeingDragged = false;
        }
    }

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){


    Shapes newShape;
    newShape.setup(touch);
    myShapes.push_back(newShape);
    
    start = true;

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

//--------------------------------------------------------------

