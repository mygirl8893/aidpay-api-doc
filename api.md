---
sidebarDepth: 3
---

# API

## Getting Started

You need Generate Api Key and Secret.

Contact AidCoin to have your Api Key and Secret [here](https://www.aidchain.co/aidpay).


## SDK

We provided a PHP SDK that can be easily integrated through composer. 

```bash
composer require aidcoinco/aidpay-php
```

You can also use it as example by viewing our code on [GitHub](https://github.com/aidcoinco/aidpay-php).


## Usage

You can use our SDK or implementing your and calling our APIs at 

```
https://www.aidchain.co/api/v1/aidpay/payments
```

For each API call you must provide as Header

* `Content-Type: application/json`
* `api-key: <your api key>`
* `sign: <signed message from API call body>`

Note: *sign* is a keyed hash value using the HMAC method.


### GET /payments/charities

Description:
+ Returns the list of enabled charities.

Params:
+ array with limit (default 12) and offset (default 0) 

Request:

```bash
curl -X GET \
  https://www.aidchain.co/api/v1/aidpay/payments/charities?limit=2&offset=0 \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>'
```

Response: 

```json
{
  "data": [
    {
      "id": 1,
      "name": "Friends Charity",
      "logo": "https://www.aidchain.io/image/charity/friends-charity.jpeg",
      "url": "https://www.aidchain.io/charity/friends-charity"
    },
    {
      "id": 2,
      "name": "Save Us Charity",
      "logo": "https://www.aidchain.io/image/charity/save-us-charity.jpeg",
      "url": "https://www.aidchain.io/charity/save-us-charity"
    }
  ],
  "count": 7,
  "pagination": {
    "page": 1,
    "pages": 4,
    "next": "/api/v1/aidpay/payments/charities?limit=2&offset=2",
    "prev": null
  }
}
```


### GET /payments/currencies

Description:
+ Returns the list of enabled currencies as a flat array with the associated AID rate value.

Request:

```bash
curl -X GET \
  https://www.aidchain.co/api/v1/aidpay/payments/currencies \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>'
```

Response: 

```json
[
  {
    "name": "Attention Token",
    "code": "BAT",
    "aid_rate": "2.4326873385"
  },
  {
    "name": "Blackcoin",
    "code": "BC",
    "aid_rate": "1.2065245478"
  },
  {
    "name": "Bitcoin",
    "code": "BTC",
    "aid_rate": "61369.5090439273"
  },
  {
    "name": "Dai Stablecoin",
    "code": "DAI",
    "aid_rate": "7.444121447"
  },
  {
    "name": "Dash",
    "code": "DASH",
    "aid_rate": "1842.9453811369"
  },
  {
    "name": "Decred",
    "code": "DCR",
    "aid_rate": "487.2174418604"
  },
  {
    "name": "Digixdao",
    "code": "DGD",
    "aid_rate": "707.5329457364"
  },
  {
    "name": "Dogecoin",
    "code": "DOGE",
    "aid_rate": "0.0257751937"
  },
  {
    "name": "Essentia",
    "code": "ESS",
    "aid_rate": "0.0552325581"
  },
  {
    "name": "Ethereum",
    "code": "ETH",
    "aid_rate": "3557.2835917926"
  },
  {
    "name": "Flyp.me Token",
    "code": "FYP",
    "aid_rate": "0.7364341085"
  },
  {
    "name": "Gamecredits",
    "code": "GAME",
    "aid_rate": "3.5385658914"
  },
  {
    "name": "Gridcoin",
    "code": "GRC",
    "aid_rate": "0.2424095607"
  },
  {
    "name": "Groestlcoin",
    "code": "GRS",
    "aid_rate": "5.5158914728"
  },
  {
    "name": "Litecoin",
    "code": "LTC",
    "aid_rate": "647.1420865633"
  },
  {
    "name": "Pivx",
    "code": "PIVX",
    "aid_rate": "14.5648255813"
  },
  {
    "name": "Peercoin",
    "code": "PPC",
    "aid_rate": "8.5309754521"
  },
  {
    "name": "Augur",
    "code": "REP",
    "aid_rate": "226.276744186"
  },
  {
    "name": "Syscoin",
    "code": "SYS",
    "aid_rate": "1.2415051679"
  },
  {
    "name": "BLOCKv",
    "code": "VEE",
    "aid_rate": "0.1528100775"
  },
  {
    "name": "Vertcoin",
    "code": "VTC",
    "aid_rate": "10.0830103359"
  },
  {
    "name": "Zcash",
    "code": "ZEC",
    "aid_rate": "1669.2506459948"
  },
  {
    "name": "0x",
    "code": "ZRX",
    "aid_rate": "8.4763565891"
  }
]
```


### GET /payments/[from-currency]/limits

Description:
+ Returns the min and max amounts of tokens to be exchanged both in AID and in selected currency.

Params:
+ fromCurrency: the currency from which to start the transaction

Request:

```bash
curl -X GET \
  https://www.aidchain.co/api/v1/aidpay/payments/BTC/limits \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>'
```

Response: 

```json
{
  "AID": {
    "min": "9.0",
    "max": "26519.21353053"
  },
  "BTC": {
    "min": "0.000138789473684",
    "max": "0.408954187602"
  }
}
```


### GET /payments/[uuid]

Description:
+ Returns the status of the payment for a given uuid.

Params:
+ uuid: the unique id of the payment to search for

::: warning NOTE
Status could be 
* WAITING_FOR_DEPOSIT
* DEPOSIT_RECEIVED
* DEPOSIT_CONFIRMED
* EXECUTED
* REFUNDED
* CANCELED
* EXPIRED
:::

Request:

```bash
curl -X GET \
  https://www.aidchain.co/api/v1/aidpay/payments/aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>'
```

Response: 

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
  "orderId": "O-12345",
  "status": "WAITING_FOR_DEPOSIT",
  "email": "example@aidcoin.co",
  "depositAddress": "1HfL94JWjmmjroyAHTDhRQqUwZ7PR4JoUZ",
  "destination": "0x4Aa0f67D9A0666b9Dd0Ee6d397334903AE337e1E",
  "exchangeRate": "64625.850340136300000000",
  "fromCurrency": "BTC",
  "toCurrency": "AID",
  "invoicedAmount": "0.100000000000000000",
  "orderedAmount": "6459.585034010000000000",
  "hash": null,
  "refundAddress": "1Nv92z71iinNVPncrDm4RPHyo17S9bEVPG",
  "createdAt": "2018-07-26T14:44:28+02:00",
  "expireDate": "2018-07-26T15:04:26+02:00",
  "chargedFee": "3.000000000000000000"
}
```


### POST /payments/donation

Description:
+ Create a donation.

Params:
+ orderId: a reference for the customer (i.e. his progressive order id). Will be sent for reference in notifications
+ fromCurrency: the currency from which to start the transaction
+ invoicedAmount: the amount to convert (in "fromCurrency")
+ email: your notification email
+ itemId: the item id of the charity to send the funds to
+ refundAddress: an optional address "fromCurrency" compatible where to receive refund in case of problems with the blockchain

Request:

```bash
curl -X POST \
  https://www.aidchain.co/api/v1/aidpay/payments/donation \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>' \
  -d '{
       "orderId": "O-12345",
       "fromCurrency": "BTC",
       "invoicedAmount":0.100000000000000000,
       "email": "example@aidcoin.co",
       "itemId": "1",
       "itemType": "charity",
       "refundAddress": "1Nv92z71iinNVPncrDm4RPHyo17S9bEVPG"
     }'
```

Response: 

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
  "orderId": "O-12345",
  "status": "WAITING_FOR_DEPOSIT",
  "email": "example@aidcoin.co",
  "depositAddress": "1HfL94JWjmmjroyAHTDhRQqUwZ7PR4JoUZ",
  "destination": "0x4Aa0f67D9A0666b9Dd0Ee6d397334903AE337e1E",
  "exchangeRate": "64625.850340136300000000",
  "fromCurrency": "BTC",
  "toCurrency": "AID",
  "invoicedAmount": "0.100000000000000000",
  "orderedAmount": "6459.585034010000000000",
  "hash": null,
  "refundAddress": "1Nv92z71iinNVPncrDm4RPHyo17S9bEVPG",
  "createdAt": "2018-07-26T14:44:28+02:00",
  "expireDate": "2018-07-26T15:04:26+02:00",
  "chargedFee": "3.000000000000000000"
}
```


### POST /payments/cancel

Description:
+ Delete a payment for a given uuid.

Params:
+ uuid: the unique id of the payment to search for

Request:

```bash
curl -X POST \
  https://www.aidchain.co/api/v1/aidpay/payments/cancel \
  -H 'Content-Type: application/json' \
  -H 'api-key: <your api key>' \
  -H 'sign:  <signed message from API call body>' \
  -d '{
       "uuid": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
     }'
```

Response:  

```json
{
  "uuid": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
  "orderId": "O-12345",
  "status": "CANCELED",
  "email": "example@aidcoin.co",
  "depositAddress": "1HfL94JWjmmjroyAHTDhRQqUwZ7PR4JoUZ",
  "destination": "0x4Aa0f67D9A0666b9Dd0Ee6d397334903AE337e1E",
  "exchangeRate": "64625.850340136300000000",
  "fromCurrency": "BTC",
  "toCurrency": "AID",
  "invoicedAmount": "0.100000000000000000",
  "orderedAmount": "6459.585034010000000000",
  "hash": null,
  "refundAddress": "1Nv92z71iinNVPncrDm4RPHyo17S9bEVPG",
  "createdAt": "2018-07-26T14:44:28+02:00",
  "expireDate": "2018-07-26T15:04:26+02:00",
  "chargedFee": "3.000000000000000000"
}
```


## Return url

When your payment will be `EXECUTED` you will receive a POST to your return url provided during the setup process.

::: warning NOTE
Before updating your order status you should sign the call BODY with your API Secret and then check that it matches our provided sign in HEADERS.
:::

```bash
curl -X POST \
  https://your-provided-return-url \
  -H 'Content-Type: application/json' \
  -H 'sign: <signed message from body below>' \
  -d '{
        "uuid": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
        "orderId": "O-12345",
        "status": "EXECUTED",
        "email": "example@aidcoin.co",
        "depositAddress": "1HfL94JWjmmjroyAHTDhRQqUwZ7PR4JoUZ",
        "destination": "0x4Aa0f67D9A0666b9Dd0Ee6d397334903AE337e1E",
        "exchangeRate": "64625.850340136300000000",
        "fromCurrency": "BTC",
        "toCurrency": "AID",
        "invoicedAmount": "0.100000000000000000",
        "orderedAmount": "6459.585034010000000000",
        "hash": "0xc28b0..........ac11",
        "refundAddress": "1Nv92z71iinNVPncrDm4RPHyo17S9bEVPG",
        "createdAt": "2018-07-26T14:44:28+02:00",
        "expireDate": "2018-07-26T15:04:26+02:00",
        "chargedFee": "3.000000000000000000"
      }'
```