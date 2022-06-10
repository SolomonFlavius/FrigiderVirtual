# Firebase cloud functions for virtual-fridge

## Content

Firebase schedule functions.

- sendAlertForProductsSoonToExpire - will run every day at 6 AM Bucharest timezone; will send a fcm notification to each user who has products that are soon to expire
- sendAlertForProductsExpired - will run every day at 6 AM Bucharest timezone; will send a fcm notification to each user who has products that are expired

## Deploy the cloud functions

```bash
firebase deploy --only functions
```
