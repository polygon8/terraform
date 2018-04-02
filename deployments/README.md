Create a deployment directory, e.g. rhagolwg
Go into that directory and copy all the tmpl files, dropping the .tmpl
Edit the tmpls so they match your deployment directory

If you don't edit them they should fail with a syntax error.

Once they work, run the following:

`terraform init`

`terraform plan -lock=false`

`terraform apply -lock=false`

You now have your terraform state setup with dynamodb locking for that deployment.

Go forth and create more terraform!

Use `TF_VAR_access_key=<aws_access_key> TF_VAR_secret_key=aws_secret_access_key terraform (plan|apply)`
