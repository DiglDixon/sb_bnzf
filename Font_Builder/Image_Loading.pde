

// class LetterImageSet{
// 	private char letterValue;
// 	PImage[] cachedImages;

// 	public LetterImageSet(char c){
// 		letterValue = c;
// 	}

	
// 	public void cacheAnimationImages(){
// 		cachedImages = new PImage[style.animationFrameCount];
// 		String filePath;
// 		println("Caching images for "+myValue);
// 		for(int k = 0; k<cachedImages.length; k++){
// 			filePath = style.getImagePath(myValue, k);
// 			cachedImages[k] = requestImage(filePath);
// 		}
// 	}

// 	// 0: still loading, -1: error, 1: loaded
// 	public int cachedImageLoadState(){
// 		boolean error = false;
// 		boolean unloaded = false;
// 		for(int k = 0; k<cachedImages.length; k++){
// 			if(cachedImages[k].width==0)
// 				unloaded = true;
// 			if(cachedImages[k].width==-1)
// 				error = true;
// 		}
// 		if(error)
// 			return -1;
// 		if(unloaded)
// 			return 0;
// 		return 1;
// 	}

// }