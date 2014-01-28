class CabRequestMailer < ActionMailer::Base
  ActionMailer::Base.delivery_method = :smtp
  default :from => "twcabrequest@gmail.com",
          :reply_to => "ggnfacilities@thoughtworks.com,damandek@thoughtworks.com"

# send a signup email to the user, pass in the user object that contains the user's email address
  def send_admin_email(cab_request,pick_up_date,pick_up_time,requester,admin_emails)
    mail(reply_to:[requester,admin_emails],  cc: [admin_emails,requester] , subject: "[Cab Request]", content_type: "text/html", body:

                                                        "<p> Name :\t" + cab_request.traveler_name + "</p>" +

                                                        "<p> Contact_no :\t" + cab_request.contact_no + "</p>" +

                                                        "<p> From :\t" + cab_request.source + "</p>" +

                                                        "<p> To :\t" + cab_request.destination + "</p>" +

                                                        "<p> On :\t" + pick_up_date.to_s + "</p>" +

                                                        "<p> At :\t" + pick_up_time.to_s + "</p>" +

                                                        "<p> Vehicle Type :\t" + cab_request.vehicle_type + "</p>" +

                                                        "<p> Project :\t" + cab_request.project + "</p>" +

                                                        "<p> Comments :\t" + cab_request.comments + "</p>" +

                                                        "<p> Status :\t" + cab_request.status + "</p>")

  end

  def send_vendor_email(cab_request,pick_up_date,pick_up_time,requester,admin_emails,vendor_email,vendor_id,host)
    mail(reply_to:[requester,admin_emails],  cc: [vendor_email] , subject: "[Cab Request]", content_type: "text/html", body:

        "<form action='" + host +"/vendor_response/"+ cab_request.id.to_s + "/submit_response'>" +

        "<p> Name :\t" + cab_request.traveler_name + "</p>" +

        "<p> Contact_no :\t" + cab_request.contact_no + "</p>" +

        "<p> From :\t" + cab_request.source + "</p>" +

        "<p> To :\t" + cab_request.destination + "</p>" +

        "<p> On :\t" + pick_up_date.to_s + "</p>" +

        "<p> At :\t" + pick_up_time.to_s + "</p>" +

        "<p> Vehicle Type :\t" + cab_request.vehicle_type + "</p>" +

        "<p> Project :\t" + cab_request.project + "</p>" +

        "<p> Comments :\t" + cab_request.comments + "</p>" +

        "<p> Status :\t" + cab_request.status + "</p>" +

        "<p> If you cannot send the cab press NO:  \t" +

        "<input type='hidden' name='vendor_id' value='"+ vendor_id.to_s + "'/>" +

        "<button type=submit>NO</button>")
  end

  def send_admin_refusal_email(cab_request,pick_up_date,pick_up_time,admin_emails,refusal_msg)
    mail(reply_to:[],  cc: [admin_emails] , subject: "[Cab Request]", content_type: "text/html", body:

            "<p> Name :\t" + cab_request.traveler_name + "</p>" +

            "<p> Contact_no :\t" + cab_request.contact_no + "</p>" +

            "<p> From :\t" + cab_request.source + "</p>" +

            "<p> To :\t" + cab_request.destination + "</p>" +

            "<p> On :\t" + pick_up_date.to_s + "</p>" +

            "<p> At :\t" + pick_up_time.to_s + "</p>" +

            "<p> Vehicle Type :\t" + cab_request.vehicle_type + "</p>" +

            "<p> Project :\t" + cab_request.project + "</p>" +

            "<p> Comments :\t" + cab_request.comments + "</p>" +

            "<p> Status :\t" + cab_request.status + "</p>" +

            "<p>" + refusal_msg + "</p> ")

  end
end
