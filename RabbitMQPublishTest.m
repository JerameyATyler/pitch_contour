for i = 1:100
%java.lang.System.currentTimeMillis()
	str = java.lang.String.valueOf(i+8000);
	mqwrapper.MessagePublisher.send(java.lang.StringBuilder(str).append(' message ').toString(),'amq.topic', 'localhost', 'CIR.pitchtone.huang', true, 'guest', 'guest');
end