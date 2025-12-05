/**
 * @author        Michael Archbold (https://github.com/marchbold)
 * @created        17/11/2025
 */
package com.distriqt.test.agerange
{
	import com.distriqt.extension.agerange.AgeRange;
	import com.distriqt.extension.agerange.AgeRangeRequest;
	import com.distriqt.extension.agerange.AgeRangeResult;
	import com.distriqt.extension.agerange.AgeRangeUserStatus;

	import starling.display.Sprite;

	/**
	 */
	public class AgeRangeTests extends Sprite
	{
		public static const TAG:String = "";

		private var _l:ILogger;

		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		public function AgeRangeTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "AgeRange Supported: " + AgeRange.isSupported );
				if (AgeRange.isSupported)
				{
					log( "AgeRange Version:   " + AgeRange.service.version );
				}

			}
			catch (e:Error)
			{
				trace( e );
			}
		}


		////////////////////////////////////////////////////////
		//
		//

		public function setTestDetails():void
		{
			log( "setTestDetails()")
			AgeRange.instance.setFakeAgeRangeResult(
					new AgeRangeResult()
							.setAgeLower( 13 )
							.setAgeUpper( 15 )
							.setUserStatus( AgeRangeUserStatus.SUPERVISED )
							.setInstallId( "FAKE_INSTALL_ID_12345" )
			);
		}

		public function clearTestDetails():void
		{
			log( "clearTestDetails()" )
			AgeRange.instance.setFakeAgeRangeResult( null );
		}


		public function ageRequest():void
		{
			log( "ageRequest()" );
			var request:AgeRangeRequest = new AgeRangeRequest()
					.setAgeGates( 13, 16, 18 );



			AgeRange.instance.requestAgeRange(
					request,
					function ( result:AgeRangeResult )
					{
						log( "ageRequest SUCCESS" );
						log( JSON.stringify( result.toObject() ) );
					},
					function ( error:Error )
					{
						log( "ageRequest ERROR: " + error.message );
					}
			);
		}


	}
}
