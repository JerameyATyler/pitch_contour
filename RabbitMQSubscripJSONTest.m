evt = mqwrapper.MessagingEvent;

h = handle(evt,'CallbackProperties');
set(evt,'ListenCallback',@(h,e)myCallbackJSONFcn(h,e));
%129.161.106.19 for transcript worker
%*.final.transcript: channel for getting JSON
subscriber = mqwrapper.MessageSubscriber(mqwrapper.QueueingConsumerFactory.getConsumer('amq.topic', '129.161.106.19' ,'*.final.transcript', true, 'guest', 'guest'),evt);
java.lang.Thread(subscriber).start