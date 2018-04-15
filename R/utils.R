print.aws_kms_key <- function(x, ...) {
    cat(sprintf("KeyId:        %s\n", x$KeyId))
    cat(sprintf("KeyArn:       %s\n", x$KeyArn))
    cat(sprintf("Description:  %s\n", x$Description))
    cat(sprintf("CreationDate: %s\n", as.POSIXct(x$CreationDate, origin = "1970-01-01")))
    cat(sprintf("KeyState:     %s\n", x$KeyState))
    cat(sprintf("Enabled:      %s\n", as.character(x$Enabled)))
    cat(sprintf("KeyManager:   %s\n", x$KeyManager))
    cat(sprintf("Origin:       %s\n", x$Origin))
    cat(sprintf("KeyUsage:     %s\n", x$KeyUsage))
    invisible(x)
}


get_kms_keyid <- function(x, ...) {
    UseMethod("get_kms_keyid")
}

get_kms_keyid.default <- function(x, ...) {
    x
}

get_kms_keyid.aws_kms_key <- function(x, ...) {
    x$KeyId
}
