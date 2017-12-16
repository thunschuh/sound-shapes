//
//  shapes.h
//  SoundShapeBox
//
//  Created by Nguyen Thu on 13/12/2017.
//

#pragma once

#include "ofxiOS.h"
#include "ofApp.h"


typedef struct{

    float x;
    float y;
    bool bBeingDragged;
    bool bOver;
    float radius;

} draggableVertex;

class Shapes {
public:
    draggableVertex curveVertices;

    ofPoint sPoint;
    int pauseCounter;
    ofSoundPlayer mySound;


    float xPoint, yPoint;



    void setup(ofPoint myPoint){
        sPoint = myPoint;
        myPoint.x = xPoint;
        myPoint.y = yPoint;

        curveVertices.x = xPoint;
        curveVertices.y = yPoint;
        curveVertices.bOver             = false;
        curveVertices.bBeingDragged     = false;
        curveVertices.radius = 4;
        
        int random = ofRandom(0,46);
       

        mySound.load(ofToString(random)+".wav");
        mySound.setLoop(true);
        mySound.play();




    }
    


    void draw(){
        
        ofFill();
        ofDrawCircle(sPoint, 20);
        
        mySound.setLoop(true);
        mySound.setSpeed(ofMap(xPoint,0,ofGetWidth(),-2,2));
        mySound.setVolume(ofMap(yPoint,ofGetHeight(),0,0,1));

        
    }
    
    void handleTouch(ofPoint touch){
        if (touch.distance(sPoint) < 30 && curveVertices.bBeingDragged == true){
            // Start dragging
            curveVertices.bOver = true;
            sPoint = touch;
        }
    }


  
};

