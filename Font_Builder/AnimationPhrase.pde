

public class AnimatedPhrase{

	String myPhrase;
	FontAnimationStyle style;
	AnimatedLetter[] letters;
	float sc = 1;
	float tracking = 0;
	boolean phraseLoaded = false;
	int displayFrame = 0;

	public AnimatedPhrase(String phrase, FontAnimationStyle style){
		this.style = style;
		setPhrase(phrase);
	}

	public void setPhrase(String phrase){
		myPhrase = phrase;
		letters = new AnimatedLetter[myPhrase.length()];
		for(int k = 0; k<letters.length; k++){
			letters[k] = AnimatedLetterFactory.constructAnimatedLetter(myPhrase.charAt(k), style);
		}
		updateLetterPositions();
		setStagger(-2);
		loadPhrase();
	}

	public void updateLetterPositions(){
		float cumulativeWidth = 0;
		float cumulativeHeight = 0; // Not worrying about this just yet. Leading too.
		float cumulativeKerning = 0;
		// float cumulativeTracking = 0;
		for(int k = 0; k<letters.length; k++){
			letters[k].setPosition(cumulativeWidth + k * tracking + cumulativeKerning, cumulativeHeight);
			cumulativeKerning += letters[k].kerning;
			cumulativeWidth += letters[k].getWidth();
		}
	}

// This was a bombshell! We need to work per-letter, individually store values, have
// a function to easily grab the x and y offset that being in a sentence implies on the letter
	public AnimatedLetter getLetterAtPosition(float x, float y){
		Bounds b;
		for(int k = 0; k<letters.length; k++){
			b = letters[k].letterBounds;
			fill(255, 255, 0, 50);
			previewWindow.pushTransform();
			b.display();
			previewWindow.popTransform();
			if(b.contains(x, y)){
				return letters[k];
			}
		}

		return null;
	}

	public void setStagger(int frameStagger){
		for(int k = 0; k<letters.length; k++){
			letters[k].setAnimationStartFrame(k*frameStagger);
		}
	}

	public void setDisplayFrame(int frame){
		displayFrame = frame;
	}

	public void incrementAnimationFrame(){
		for(int k = 0; k<letters.length; k++){
			letters[k].incrementAnimationFrame();
		}
	}

	public boolean animationComplete(){
		for(int k = 0; k<letters.length; k++){
			if(!letters[k].animationComplete())
				return false;
		}
		return true;
	}

	public void resetAnimation(){
		for(int k = 0; k<letters.length; k++){
			letters[k].resetAnimation();
		}
	}

	public void display(PGraphics pg){
		if(!phraseLoaded){
			return;
		}
		pg.beginDraw();
		pg.pushMatrix();
		pg.scale(sc);
		float x = 0, y = 0;
		String previousChars;
		for(int k = 0; k<myPhrase.length();k++){
			x = letters[k].xPosition;
			x += letters[k].kerning;
			if(! letters[k].canDisplay()){
				continue;
			}
			pg.image(letters[k].getImage(), x, y);
		}
		pg.popMatrix();
		pg.endDraw();
	}

	public int getPhraseAnimationFrameCount(){
		int biggestStagger = 0;
		for(int k = 0; k<letters.length; k++){
			biggestStagger = min(letters[k].animationStartFrame, biggestStagger);
		}
		return (-biggestStagger + style.animationFrameCount);
	}


	// LOADING - how to split into separate class?

	private void loadPhrase(){
		phraseLoaded = false;
		for(int k = 0; k<letters.length; k++){
			letters[k].cacheAnimationImages();
		}
		SKETCH.registerMethod("draw", this);
	}

	// We use this for loading.
	void draw(){
		boolean loaded = true;
		int state = 0;
		for(int k = 0; k<letters.length; k++){
			state = letters[k].cachedImageLoadState();
			// error
			if(state==-1){
				loadFailed();
			}
			// incomplete
			if(state==0){
				loaded = false;
			}
		}
		if(loaded)
			loadComplete();
		UI.displayLoadWheel();
	}

	public boolean readyForPreviewCaching(){
		return phraseLoaded;
	}

	private void loadFailed(){
		println("ERROR: Load failed unexpectedly!");
		phraseLoaded = false;
		SKETCH.unregisterMethod("draw", this);		
	}

	private void loadComplete(){
		phraseLoaded = true;
		SKETCH.unregisterMethod("draw", this);
	}
}


