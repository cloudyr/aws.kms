# AWS KMS Client Package.

**aws.kms** is a package for the [AWS KMS Service](https://aws.amazon.com/kms/).

To use the package, you will need an AWS account and to enter your credentials into R. Your keypair can be generated on the [IAM Management Console](https://aws.amazon.com/) under the heading *Access Keys*. Note that you only have access to your secret key once. After it is generated, you need to save it in a secure location. New keypairs can be generated at any time if yours has been lost, stolen, or forgotten. The [**aws.iam** package](https://github.com/cloudyr/aws.iam) profiles tools for working with IAM, including creating roles, users, groups, and credentials programmatically; it is not needed to *use* IAM credentials.

To use the package, you will need an AWS account and to enter your credentials into R. Your keypair can be generated on the [IAM Management Console](https://aws.amazon.com/) under the heading *Access Keys*. Note that you only have access to your secret key once. After it is generated, you need to save it in a secure location. New keypairs can be generated at any time if yours has been lost, stolen, or forgotten. The [**aws.iam** package](https://github.com/cloudyr/aws.iam) profiles tools for working with IAM, including creating roles, users, groups, and credentials programmatically; it is not needed to *use* IAM credentials.

A detailed description of how credentials can be specified is provided at: https://github.com/cloudyr/aws.signature/. The easiest way is to simply set environment variables on the command line prior to starting R or via an `Renviron.site` or `.Renviron` file, which are used to set environment variables in R during startup (see `? Startup`). They can be also set within R:

```R
Sys.setenv("AWS_ACCESS_KEY_ID" = "mykey",
           "AWS_SECRET_ACCESS_KEY" = "mysecretkey",
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_SESSION_TOKEN" = "mytoken")
```


## Code Examples

The core function in **aws.kms** is `create_kms_key()` which generates a KMS encryption key.

```R
library("aws.kms")

# create key
k <- create_kms_key(description = "example")
# get key
get_kms_key(k)
```

With a key, it is possible to do arbitrary encryption:

```R
# encrypt
tmp <- tempfile()
cat("example test", file = tmp)
(etext <- encrypt(tmp, k))

# decrypt
(dtext <- decrypt(etext, k, encode = FALSE))
if (require("base64enc")) {
    rawToChar(base64enc::base64decode(dtext))
}
```


## Installation

[![CRAN](https://www.r-pkg.org/badges/version/aws.kms)](https://cran.r-project.org/package=aws.kms)
![Downloads](https://cranlogs.r-pkg.org/badges/aws.kms)
[![RForge](https://rforge.net/do/versvg/aws.kms)](https://RForge.net/aws.kms)
[![Travis Build Status](https://travis-ci.org/cloudyr/aws.kms.png?branch=master)](https://travis-ci.org/cloudyr/aws.kms)
[![codecov.io](https://codecov.io/github/cloudyr/aws.kms/coverage.svg?branch=master)](https://codecov.io/github/cloudyr/aws.kms?branch=master)

Latest stable release from CRAN:

```R
install.packages("aws.kms", repos = "https://cloud.R-project.org")
```

Lastest development version from RForge.net:

```R
install.packages("aws.kms", repos = c("https://RForge.net", "https://cloud.R-project.org"))
```

On Windows you may need to add `INSTALL_opts = "--no-multiarch"`

---
[![cloudyr project logo](https://i.imgur.com/JHS98Y7.png)](https://github.com/cloudyr)
