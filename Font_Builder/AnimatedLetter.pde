// If this extended a null class, we'd need to override much less in children.
class AnimatedLetter{

	FontAnimationStyle style;
	private char myValue;
	PImage displayImage;
	PImage[] cachedImages;

	float xPosition, yPosition;
	Bounds letterBounds = new Bounds();
	float kerning = 0;
	float letterWidth;
	int animationFrame;
	int animationStartFrame = 0;

	public AnimatedLetter(char v, FontAnimationStyle style){
		this.style = style;
		setValue(v);
	}

	private void setValue(char v){
		myValue = v;
		letterWidth = style.getCharWidth(myValue);
	}

	public char getValue(){
		return myValue;
	}	

	public void setPosition(float x, float y){
		xPosition = x;
		yPosition = y;
		updateLetterBounds();
	}

	public void updateLetterBounds(){
		float ascent = style.getLetterAscent();
		letterBounds.x = getDisplayPositionX() + style.letterOriginInImage;
		letterBounds.y = style.letterBaselineInImage - ascent;
		letterBounds.w = getWidth();
		letterBounds.h = ascent + style.getLetterDescent();
	}

	public float getDisplayPositionX(){
		return xPosition + kerning;
	}

	public float getWidth(){
		return letterWidth;
	}

	public void cacheAnimationImages(){
		cachedImages = new PImage[style.animationFrameCount];
		String filePath;
		println("Caching images for "+myValue);
		for(int k = 0; k<cachedImages.length; k++){
			filePath = style.getImagePath(myValue, k);
			cachedImages[k] = requestImage(filePath);
		}
	}

	// 0: still loading, -1: error, 1: loaded
	public int cachedImageLoadState(){
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

	public void setAnimationStartFrame(int i){
		animationStartFrame = i;
	}

	public void resetAnimation(){
		animationFrame = animationStartFrame;
	}

	public boolean canDisplay(){
		return (!isBlankSpace() && supportedAnimationFrame());
	}

	public boolean isBlankSpace(){
		return myValue == (' ');
	}

	public void setAnimationFrame(int f){
		animationFrame = f;
	}

	public boolean animationComplete(){
		return (animationFrame == style.animationFrameCount-1);
	}

	public void incrementAnimationFrame(){
		animationFrame = min(animationFrame + 1, style.animationFrameCount-1);
	}

	public boolean supportedAnimationFrame(){
		return (animationFrame >=0 && animationFrame <style.animationFrameCount);
	}

	public PImage getImage(){
		return cachedImages[animationFrame];
	}

	public PImage getFrameImage(int index){
		return cachedImages[index];
	}

}

class AnimatedLetterSpace extends AnimatedLetter{
	public AnimatedLetterSpace(FontAnimationStyle style){
		super(' ', style);
	}

	public void cacheAnimationImages(){
		// override
	}

	public int cachedImageLoadState(){
		// override
		return 1;
	}
}

class AnimatedLetterDuplicate extends AnimatedLetter{
	AnimatedLetter reference;

	public AnimatedLetterDuplicate(AnimatedLetter reference){
		super(reference.myValue, reference.style);
		this.reference = reference;
	}
	public void cacheAnimationImages(){
		// override
	}
	public int cachedImageLoadState(){
		// override
		return reference.cachedImageLoadState();
	}

	public PImage getImage(){
		return reference.getFrameImage(animationFrame);
	}

	public PImage getFrameImage(int frame){
		return reference.getFrameImage(frame);
	}
}
