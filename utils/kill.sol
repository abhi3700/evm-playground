function kill() {
	if (msg.sender == creator) {
		suicide(creator);		  // kills this contract and sends remaining funds back to creator
	}
}