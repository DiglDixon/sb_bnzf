
// AnimatedLetterFactory, statics are a nightmare in Processing.
_AnimatedLetterFactory AnimatedLetterFactory = new _AnimatedLetterFactory();
class _AnimatedLetterFactory{

	ArrayList constructedLetters = new ArrayList<AnimatedLetter>();

	public _AnimatedLetterFactory(){}

	public AnimatedLetter constructAnimatedLetter(char c, FontAnimationStyle style){
		if(style.characterSupported(c)){
			return new AnimatedLetter(c, style);
		}else{
			return new AnimatedLetter('x', style);
		}
		// if(c==' '){
		// 	return new AnimatedLetterSpace(style);
		// }
		// AnimatedLetter existing;
		// AnimatedLetter al;
		// if(imageSequenceExists(c, style)){
		// 	existing = existingMatchingLetter(c);
		// 	if(existing!=null){
		// 		return new AnimatedLetterDuplicate(existing);
		// 	}else{
		// 		al = new AnimatedLetter(c, style);
		// 		constructedLetters.add(al);
		// 		return al;
		// 	}
		// }else{
		// 	return new AnimatedLetterSpace(style);
		// }
	}

	// private AnimatedLetter existingMatchingLetter(char c){
	// 	AnimatedLetter al;
	// 	for(int k = 0; k<constructedLetters.size(); k++){
	// 		al = (AnimatedLetter) constructedLetters.get(k);
	// 		if(al.myValue==c)
	// 			return al;
	// 	}
	// 	return null;
	// }

	// private boolean imageSequenceExists(char v, FontAnimationStyle style){
	// 	String filePath = style.getImagePath(v);
	// 	File f = new File(dataPath(filePath));
	// 	return f.exists();
	// }
}