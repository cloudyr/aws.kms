#' @rdname rotation
#' @title Enable/Disable Key Rotation
#' @description Enable or disable a encryption key rotation
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @seealso \code{\link{create_kms_key}}, \code{\link{list_kms_keys}}
#' @examples
#' \dontrun{
#'   # create key
#'   k <- create_kms_key(description = "example")
#'   
#'   # enable rotation
#'   enable_kms_rotation(k)
#'   
#'   # disable rotation
#'   disable_kms_rotation(k)
#'   
#'   # confirm rotation is disabled
#'   get_kms_rotation(k)
#'   
#'   # delete in 7 days
#'   delete_kms_key(k)
#' }
#' @export
enable_kms_rotation <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "EnableKeyRotation", body = bod, ...)
    return(TRUE)
}

#' @rdname rotation
#' @export
disable_kms_rotation <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "DisableKeyRotation", body = bod, ...)
    return(TRUE)
}

#' @rdname rotation
#' @export
get_kms_rotation <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "GetKeyRotationStatus", body = bod, ...)
    return(out$KeyRotationEnabled)
}
