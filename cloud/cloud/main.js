var TWILIO_ACCOUNT_SID = "AC66c9ea5429517d983d0f9eec0b7adcc4";
var TWILIO_AUTH_TOKEN = "c77ff9cd7f6efaa52272f6f807f4c171";
var twilio = require('twilio')(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN);

Parse.Cloud.define("send_twilio_message", function(request, response) {

    var Mentor = Parse.Object.extend("Mentor");
    var Student = Parse.Object.extend("Student");

    var mentorQuery = new Parse.Query(Mentor);
    var studentQuery = new Parse.Query(Student);

    query.find({
      success: function(results) {

        twilio.sms.messages.create({
            to: "+19494916672",
            from: "+12016907828",
            body: "Hey Chris, here's the address and price of the apartment you were looking at! " + results[1].get('mentorLanguage') + ' ' + results[1].get('mentorLocation')
          },
          function(error, msg) {
            if (error) {
              response.error(error);
            } else {
              response.success();
            }
          });
        }
        });
        });



/*
curl -X POST \
 -H "X-Parse-Application-Id: rnZZaWcFIDPSXcyAS93w5WTCqGH3mirGOC4TREXw" \
 -H "X-Parse-REST-API-Key: Jaz6ee2pguJCTSNkNwqkw27a5P6nlnOwxLAguS3q" \
 -H "Content-Type: application/json" \
 -d '{}' \
 https://api.parse.com/1/functions/send_twilio_message
 */
