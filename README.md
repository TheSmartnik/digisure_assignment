## Setup Instructions

Standard rails application setup

```bash
  bundle install
  bin/rails db:setup  # This will also load test data
```

You can confirm that everything is working by running specs

```bash
bundle exec rspec
```

## Implementation Notes
Registration is somewhat product driven. Questions like:
- Do we need a password confirmation or we want as simple sign up as possible?
- What security requirements should we add to our passwords?

I've purposefully haven't answered those questions myself since they are both opiniated and not challanging to introduce

## High priority features

### From Product Perspective
There are multiple things that can be improved in terms of security UX. Although, some of them would require introduction of ActionMailer

1. Password Recovery or Password reset
2. ApiTokens endpoints
  a. Save current user agents or other device information
  a. List all currently used api tokens
  b. Retract access from all tokens

### From Home Assignment perspective
1. Add loyalty system when user makes first deposit transfer
