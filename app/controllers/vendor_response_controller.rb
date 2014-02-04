class VendorResponseController < ApplicationController

  #skip_before_filter CASClient::Frameworks::Rails::Filter #, :only => [:edit]

  def submit_response
    @cab_request = CabRequest.find(params[:id])
    logger.info('VENDOR ID IS: '+@cab_request.requested_vendor.to_s)
    if(@cab_request.requested_vendor.to_s == params[:vendor_id])

      requester = @cab_request.requester + '@thoughtworks.com'

      admin_emails  = Admin.where(status: true).pluck(:email)
      if admin_emails.include? requester
        requester = ""
      end

      refusing_vendor_email = Vendor.where(id: params[:vendor_id]).pluck(:email).first
      refusing_vendor_order = Vendor.where(id: params[:vendor_id]).first.order
      vendor_email = Vendor.where(order: refusing_vendor_order + 1).pluck(:email).first
      vendor_id = Vendor.where(order: refusing_vendor_order + 1).pluck(:id).first
      host = "http://" + request.host_with_port

     begin
     if vendor_email.nil?
        CabRequestMailer.send_admin_refusal_email(@cab_request,@cab_request.pick_up_date_time.to_date,@cab_request.pick_up_date_time.strftime("%I:%M %P"),admin_emails,"ALL VENDORS REFUSED TO SEND CABS.").deliver
     else
       refusal_msg = "Vendor: "+ refusing_vendor_email +" refused to send a cab. Now, a request is being sent to vendor: "+ vendor_email
       CabRequestMailer.send_admin_refusal_email(@cab_request,@cab_request.pick_up_date_time.to_date,@cab_request.pick_up_date_time.strftime("%I:%M %P"),admin_emails,refusal_msg).deliver
       CabRequestMailer.send_vendor_email(@cab_request,@cab_request.pick_up_date_time.to_date,@cab_request.pick_up_date_time.strftime("%I:%M %P"),requester,admin_emails,vendor_email,vendor_id,host).deliver
     end
       @cab_request.update_column('requested_vendor', vendor_id)
       render partial: 'vendor_response/index'
     rescue Exception => e
       render partial: 'vendor_response/error'
     end
    else
      render partial: 'vendor_response/already_recorded'
    end
  end

end
