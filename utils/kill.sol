function kill() {
	if (msg.sender == creator) {
		selfdestruct(creator);		  // kills this contract and sends remaining funds back to creator
	}
}