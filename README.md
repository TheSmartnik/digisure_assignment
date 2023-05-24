## Setup Instructions

Standard rails application setup

```bash
  bundle install
  bin/rails db:setup
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

### From Home Assignment Perspective
1. Add loyalty system when user makes first deposit/transfer

## Endpoints Documentation

### General Notes

* All Endpoints may return `404` or `422` errors with body containing `error_message`
* For authentication pass header `X-API-TOKEN` with token you acquire from authentication or user creation

### Authentication

```
POST /user
```

Request Params
|Field|Required|Type|
|:-|:-|:-|
|email|true|String|
|password|true|String|

Response Body
```json
{
  "api_token":"b2ae5fce5685902c2a0728fac9a7be6f",
  "balance":0,
  "email":"email-1@email.com"
}
```
### Create User

```
POST /user
```

|Field|Required|Type|
|:-|:-|:-|
|email|true|String|
|password|true|String|

Response Body
```json
{
  "api_token":"b2ae5fce5685902c2a0728fac9a7be6f",
  "balance":0,
  "email":"email-1@email.com"
}
```

### Get User
```
GET /user
```

Response Body
```json
{
  "balance":0,
  "email":"email-1@email.com"
}
```

### Get User Transactions

```
GET /transactions
```

Response Body
```json
[
  {
    "created_at": "2023-05-24 09:36:03 UTC",
    "data": {},
    "operation_description": "incoming",
    "operation_type": "deposit",
    "quantity": 100
  },
  {
    "created_at": "2023-05-24 09:36:03 UTC",
    "data": {},
    "operation_description": "incoming",
    "operation_type": "deposit",
    "quantity": 100
  },
  {
    "created_at": "2023-05-24 09:36:03 UTC",
    "data": {
      "transfer_to": "user-1@email.com"
    },
    "operation_description": "outgoing",
    "operation_type": "transfer_sent",
    "quantity": 100
  }
]
```

### Deposit
```
POST /transactions
```

Request Params
|Field|Required|Type|Value|
|:-|:-|:-|:-|
|quantity|true|Integer||
|operation_type|true|String|Deposit|


### Transfer
```
POST /transactions
```

Request Params
|Field|Required|Type|Value|
|:-|:-|:-|:-|
|quantity|true|Integer||
|recipient_email|true|Integer||
|operation_type|true|String|Transfer|
