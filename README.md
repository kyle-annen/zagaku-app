# README

Zagaku app is a scheduleing application built for tracking technical talks, aids in booking talks through slack, sharing talk content and statistics, and providing a means of disemination for talk content.

Current Features:

- Polulates calendar with schedueled talks

Upcoming Features:

- Schedule talks via slack
- Broadcast talks solicitation via with rules (have not talked recently, indicates interest in giving talks)
- Statistical breakdown of talk frequency
- Generate slack badges for Zagaku awards?
- Repository navigator based on talk content (and talk creation)


Installation:

- fork and clone repository
- `bundle install`
- `rake db:migrate`
- create a application.yml
- add the following to the application.yml
``` yaml
# replace the values in brackets with values from Google API Console Project
google_client_id: '<google client id>'
google_client_secret: '<google client secret>'
# the google calendar id is available on the google cal settings page
google_calendar_id: '<google calendar id>'
website_headline: '<website headline>'
website_subheading: '<website subheading>'
```
- run the server
- `rails s`



