To setup a remote state for terraform modify the variables.tf and run the following command with your own aws_access_key and aws_secret_access_key
```
TF_VAR_access_key=<aws_access_key> TF_VAR_secret_key=aws_secret_access_key terraform plan
```

This should work and do what you expect. If so do the same with an apply.
