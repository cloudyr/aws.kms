#' @rdname enable_key
#' @title Enable/Disable Encryption Key
#' @description Enable or disable a KMS encryption key
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @seealso \code{\link{create_kms_key}}, \code{\link{list_kms_keys}}
#' @export
enable_kms_key <-
function(
  key,
  ...
) {
    bod <- list(KeyId = key)
    out <- kmsHTTP(action = "EnableKey", body = bod, ...)
    return(TRUE)
}

#' @rdname enable_key
#' @export
disable_kms_key <-
function(
  key,
  ...
) {
    bod <- list(KeyId = key)
    out <- kmsHTTP(action = "DisableKey", body = bod, ...)
    return(TRUE)
}
