
HashMap<Character, LetterImageSet> IMAGE_SETS = new HashMap<Character, LetterImageSet>();
char[] CHAR_SET = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};

void loadLetterImageSets(FontAnimationStyle style){
	LetterImageSet newSet;
	for(int k = 0; k<CHAR_SET.length; k++){
		IMAGE_SETS.put(CHAR_SET[k], new LetterImageSet(CHAR_SET[k], style));	
	}
}



public class LetterImageSet{
	private char letterValue;
	PImage[] cachedImages;
	FontAnimationStyle style;
	private boolean loaded = false;
	private boolean underway = false;
	private boolean error = false;
	public LetterImageSet(char c, FontAnimationStyle s){
		letterValue = c;
		style = s;
	}

	public void beginLoad(){
		loaded = false;
		error = false;
		underway = true;
		cachedImages = new PImage[style.animationFrameCount];
		String filePath;
		println("Caching images for "+letterValue);
		for(int k = 0; k<cachedImages.length; k++){
			filePath = style.getImagePath(letterValue, k);
			cachedImages[k] = requestImage(filePath);
		}
		SKETCH.registerMethod("draw", this);
	}

	// We use this for loading.
	void draw(){
		switch(cachedImageLoadState()){
			case 1:
			loadComplete();
			break;
			case -1:
			loadFailed();
			break;
			case 0:
			// still loading
			break;
		}
		UI.displayLoadWheel();
	}

	// 0: still loading, -1: error, 1: loaded
	private int cachedImageLoadState(){
		boolean error = false;
		boolean unloaded = false;
		for(int k = 0; k<cachedImages.length; k++){
			if(cachedImages[k].width==0)
				unloaded = true;
			if(cachedImages[k].width==-1)
				error = true;
		}
		if(error)
			return -1;
		if(unloaded)
			return 0;
		return 1;
	}

	public boolean loadUnderway(){
		return underway;
	}

	public boolean hasLoaded(){
		return loaded;
	}

	private void loadFailed(){
		println("ERROR: Load failed for "+style.animationName+" - "+letterValue);
		error = true;
		underway = false;
		SKETCH.unregisterMethod("draw", this);		
	}

	private void loadComplete(){
		loaded = true;
		underway = false;
		SKETCH.unregisterMethod("draw", this);
	}

	public PImage getFrame(int f){
		return cachedImages[f];
	}
}

public class NullLetterImageSet extends LetterImageSet{

	public NullLetterImageSet(char c, FontAnimationStyle s){
		super(c, s);

	}
	public void beginLoad(){
		// override
		return;
	}

	public boolean loadUnderway(){
		return false;
	}

	public boolean hasLoaded(){
		return true;
	}

}






//