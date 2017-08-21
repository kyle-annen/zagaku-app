class CalendarController < ApplicationController

    @@google_client_id = '585931796100-qr8703u6bu1tfsogkol6l2mhtvf6q62d.apps.googleusercontent.com'
    @@google_client_secret = 'DBU7o6WCfILiRDnCgRF4l9fI'

    def redirect
        client = Signet::OAuth2::Client.new({
            client_id: @@google_client_id,
            client_secret: @@google_client_secret, 
            authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
            scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
            redirect_uri: callback_url
        })
    
        redirect_to client.authorization_uri.to_s
    end

    def callback
        client = Signet::OAuth2::Client.new({
            client_id: @@google_client_id,
            client_secret: @@google_client_secret,
            token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
            redirect_uri: callback_url,
            code: params[:code]
        })
    
        response = client.fetch_access_token!
    
        session[:authorization] = response
    
        redirect_to calendar_url
    end

    def calendar
        client = Signet::OAuth2::Client.new({
            client_id: @@google_client_id,
            client_secret: @@google_client_secret,
            token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
        })
    
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        calendar_id = '8thlight.com_2lmksu0derpihviusb1ml7hca4@group.calendar.google.com'
        begin
            @response = service.list_events(calendar_id)
        rescue Google::Apis::AuthorizationError => exception
            response = client.refresh!
            session[:authorization] = session[:authorization].merge(response)
            retry
        end

        Meeting.delete_all

        @response.items.each do |meeting|
            @meeting = Meeting.new
            @meeting.name = meeting.summary
            @meeting.start_time = meeting.start.date_time
            @meeting.save
        end

        @meetings = Meeting.all
    end

    def create
    end
end
