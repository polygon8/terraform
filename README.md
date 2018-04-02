## Intro
Terraform will be used to create infrastructure used for the Polygon 8 website.

To do this we need an AWS account so we can can start building things and we want to collaborate as a group. This means we can't login as the same user.

Initially the AWS account will have a single person (credit card payer) associated with it. This is what I'll refer to as the root account and the root user. This account and user should never be used for anything other than administration, i.e. paying the bills. That's a problem when we want to use AWS to do things, and not just to pay them money.

AWS have identity managment, called IAM. All people interacting with AWS should be represented in IAM. When you setupan AWS account the user can do everything and is not openly displayed in IAM.

Ok, let's setup accounts for people and not use the root user. That way we can easily give the right access to the right people.

Access for things (like a bot or deployer) will be done with dedicated users for those things.

Later on, in a multi-account setup the root account would be the only place people's users would exist. There would be no system running in the root account and there would be no users for people in the non-root accounts. This would allow for different environments to have different accounts, for example, alpha, beta, live.

## Worked example of setting up some AWS admins to use instead of your root account

To create an initial admin, or many, we can click-click and do this through the aws console or if we're an admin already we can use the command line. I created my own user with AdministratorAccess then ran some of the aws commands to create the groups and other people.

The following assumes you're the user named `bootstrap` working on MacOS, who will manually create a single user called `polly`, who is a member of the admin group `terrahawks`. This will be managed in terraform eventually.

[estimated time: 30 mins]

DO NOT start without the these two things AND the time to finish!
* the root user details or a credit card to setup a new AWS account
* all the admin people need to be present to get passwords, etc.

- setup the AWS account
  - create the first user, this is your "root" account and will be tied to a payment method
  - only use this root account if admin users can't do the task
  - for extra points:
    - include a secure back-up of all the credentials
    - use a securely stored MFA device (e.g. a Yubi key in safe)
    - allow more than one admin (for backup & continuity of the organisation)

- setup `bootstrap` user in IAM using the console
  - use aws managed policy and attach it for access [`arn:aws:iam::aws:policy/AdministratorAccess`]
  - create access key for the `bootstrap` user
  - record your "Secret access key" e.g. `OsTY65lZJVm7/Z0iBBo8r8Fi8B1Xti0uM0WDgLM5A+KM3`
  - record your "Access key ID" e.g. `AKIAJGTRSVLJD2G4A`

- locate your AWS account number, available in the console's "Support Center" for this example, `<aws_account_number>`

- run `aws configure` with the details you have. This will edit the [default] profile in `~/.aws/credentials`
  ```
  AWS Access Key ID [None]: ****************2G4A
  AWS Secret Access Key [None]: ****************+KM3
  Default region name [None]: eu-west-2
  Default output format [None]: json
  ```

- use `aws sts get-caller-identity` to check who you are, it should be the `bootstrap` user
  ```
  {
      "Account": "<aws_account_number>",
      "UserId": "AIDAJNQGOPCKD288FRANM",
      "Arn": "arn:aws:iam::<aws_account_number>:user/bootstrap"
  }
  ```

- create a group :
  `aws iam create-group --group-name terrahawks`
  ```
  {
      "Group": {
          "Path": "/",
          "CreateDate": "9000-00-00T16:20:00.000Z",
          "GroupId": "AGPAOBL7YYGU0I0ONP8Q9",
          "Arn": "arn:aws:iam::<aws_account_number>:group/terrahawks",
          "GroupName": "terrahawks"
      }
  }
  ```

- attach the policy, `arn:aws:iam::aws:policy/AdministratorAccess`, to the group :
  ```
  aws iam attach-group-policy --group-name terrahawks --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
  
  ```

- create an admin user : 
  `aws iam create-user --user-name polly`

- create any other admins you need

- add admin users to the admin group : 
  `aws iam add-user-to-group --group-name terrahawks --user-name polly`

- add any other admins to the group

- create a login profile with password for `polly` https://console.aws.amazon.com : 
  ```
  aws iam create-login-profile --user-name polly --password ilovecrackers --password-reset-required
  ```

- get the admin to login and change their password : https://`<aws_account_number>`.signin.aws.amazon.com/console 

- confirm admin status by checking you are a member of the `terrahawks` group and have the `AdministratorAccess` policy attached in _IAM.. Users.. `polly`.. Permisions_

- using the newly acquired admin access more things can now happen

- go forth and build AWS stuff!!
