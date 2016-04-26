/*
To do:
- basic working
- tracking
- kerning
- staggering

- preview mode + live controls
	- kerning
	- position offset
	- scale (tricky. Maybe easily mitigated thanks to PGraphics' image() requirement?)

- Colour options


Thoughts:
- line breaks?
- scale probably won't work, due to PGraphics size.

*/

import controlP5.*;

PFont defaultFont;

FontAnimationStyle popStyle;
FontAnimationStyle bounceStyle;

AnimatedPhrase cPhrase;

int fontDisplaySize = 260;
int fontDisplayOffsetX = 212;
int fontDisplayOffsetY = 388;

PGraphics exportGraphics;

int displayIndex = 0;

String RAM_PREVIEW_PATH = "./Preview/";
PApplet SKETCH = this;
// Fake statics
_RAMPreviewPlayer RAMPreviewPlayer;
_RAMPreviewCacher RAMPreviewCacher;

void setup(){
	size(1200, 600);
	frameRate(30);
	RAMPreviewPlayer = new _RAMPreviewPlayer();
	RAMPreviewCacher = new _RAMPreviewCacher();
	exportGraphics = createGraphics(width, height);
	popStyle = new FontAnimationStyle("Pop", "SerranoPro-Light", 260);
	bounceStyle = new FontAnimationStyle("Bounce", "SerranoPro-Light", 260);
    cPhrase = new AnimatedPhrase("", bounceStyle);
    previewWindow = new PreviewWindow(new Bounds(20, 20, 1280*0.8, 720*0.8));
    // CP5 setup
    constructUI();
}

void draw(){
	
	background(255);

    previewWindow.clear();
    previewWindow.drawBorder();

	if(RAMPreviewPlayer.previewReady()){
		RAMPreviewPlayer.updateAndDisplayPreview(exportGraphics);
	}else{
        if(cPhrase.animationComplete()){
            cPhrase.resetAnimation();
        }
		displayIndex = (displayIndex+1) % 30;
        cPhrase.display(previewWindow.canvas);
        cPhrase.incrementAnimationFrame();
	}

    previewWindow.pushTransform();
	image(previewWindow.canvas, 0, 0);
    previewWindow.popTransform();

    displayUI();
	
}

void mousePressed(){
    Controls.mousePressed();
}

void mouseReleased(){
    Controls.mouseReleased();
}

void keyPressed() {
    switch(key) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        numberKeyPressed(Integer.parseInt(key+""));
        break;
        case ENTER:
        	println("Beginning export");
        	String v = cp5.get(Textfield.class,"input").getText();
        	setNewPhrase(v);
        	displayIndex = 0;
        break;
        case 'c':
        	RAMPreviewCacher.cache(cPhrase);
        break;
        case 'p':
        	RAMPreviewPlayer.runPreview();
        break;
        case 'a':
        	RAMPreviewPlayer.abortLoad();
        	break;
        default:
        //unknown key
        break;
    }
}

void setNewPhrase(String value){
	println("Setting phrase to "+value);
	cPhrase = new AnimatedPhrase(value, bounceStyle);
    // previewWindow.addMidgroundElement(cPhrase);
}

void numberKeyPressed(int n){
    println("numberKeyPressed "+n);
}

