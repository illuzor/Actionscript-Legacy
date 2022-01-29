package  {
 
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.AsyncErrorEvent;
 
 
	public class StreamTest extends MovieClip {
		public var streamUrl:String = 'http://ip:port/aac?type=.flv';
		public var stream:Sound          = new Sound();
		public var channel:SoundChannel    = new SoundChannel();
		public var connect_nc:NetConnection = new NetConnection();
		public var ns:NetStream;
 
 
		public function StreamTest() {
			this.connect_nc.connect(null);
			this.ns = new NetStream(connect_nc);
 
			//ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ayncErrorHandler);
 
			this.ns.client = {};
			this.ns.client.onMetaData = ns_onMetaData;
			this.ns.client.onCuePoint = ns_onCuePoint;
			function ns_onMetaData(item:Object):void {
    			if(item['title'])trace(item['title']);
			}
			function ns_onCuePoint(item:Object):void {
   				trace("cuePoint");
    			trace(item.name + "\t" + item.time);
			}
			this.ns.client = this;
			this.ns.play(streamUrl);
		}
 
		private function ayncErrorHandler(event: AsyncErrorEvent): void {
			// ignore for now
		}
	}
 
}