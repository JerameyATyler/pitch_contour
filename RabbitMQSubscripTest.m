evt = mqwrapper.MessagingEvent;

h = handle(evt,'CallbackProperties');
set(evt,'ListenCallback',@(h,e)myCallbackFcn(h,e));
%129.161.106.19 for transcript worker
%*.final.transcript
subscriber = mqwrapper.MessageSubscriber(mqwrapper.QueueingConsumerFactory.getConsumer('amq.topic', '129.161.106.19' ,'CIR.pitchtone.audio', true, 'guest', 'guest'),evt);
java.lang.Thread(subscriber).start

%CISL4dmin