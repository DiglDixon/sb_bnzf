
public class _RAMPreviewPlayer{

	PImage[] displayImages;
	int imageIndex = 0;
	int imageCount = 30;
	boolean imagesLoaded = false;
	boolean loadUnderway = false;

	public _RAMPreviewPlayer(){}


	public void runPreview(){
		if(imagesLoaded){
			imageIndex = 0;
		}else{
			beginLoad();
		}
	}

	private void cachePreviewImages(AnimatedPhrase phraseToCache){

	}

	private void beginLoad(){
		if(loadUnderway){
			println("Cancelled a beginLoad, as the load is already underway. Avoid these calls please.");
			return;
		}
		loadUnderway = true;
		imagesLoaded = false;
		displayImages = new PImage[imageCount];
		for(int k = 0; k<displayImages.length; k++){
			displayImages[k] = requestImage(RAM_PREVIEW_PATH+"preview_"+k+".png");
		}
		println("Beginning preview load...");
		SKETCH.registerMethod("draw", this);
	}

	// We use this for loading.
	void draw(){
		boolean loaded = true;
		int state = 0;
		for(int k = 0; k<displayImages.length; k++){
			state = displayImages[k].width;
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

	private void loadFailed(){
		loadUnderway = false;
		println("ERROR: Preview load failed unexpectedly!");
		SKETCH.unregisterMethod("draw", this);
	}

	private void loadComplete(){
		println("Preview load complete!");
		loadUnderway = false;
		imagesLoaded = true;
		SKETCH.unregisterMethod("draw", this);
	}

	public void abortLoad(){
		imagesLoaded = false;
		loadUnderway = false;
		SKETCH.unregisterMethod("draw", this);
	}

	public boolean previewReady(){
		return imagesLoaded;
	}

	public void updateAndDisplayPreview(PGraphics pg){
		imageIndex = min(imageIndex+1, imageCount-1);
		pg.beginDraw();
		pg.image(displayImages[imageIndex], 0, 0);
		pg.endDraw();
	}
}