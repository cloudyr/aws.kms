#' @rdname keys
#' @title Create/Update/Retrieve/Delete Encryption Key
#' @description Create/update/retrieve/delete a KMS encryption key
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @seealso \code{\link{list_kms_keys}}, \code{\link{create_kms_alias}}
#' @export
create_kms_key <-
function(
  ...
) {
    bod <- c()
    out <- kmsHTTP(action = "CreateKey", body = bod, ...)
    structure(out$KeyMetadata, class = "aws_kms_key")
}

#' @rdname keys
#' @export
get_kms_key <-
function(
  ...
) {
    bod <- c()
    out <- kmsHTTP(action = "CreateKey", body = bod, ...)
    structure(out$KeyMetadata, class = "aws_kms_key")
}

#' @rdname keys
#' @export
delete_kms_key <-
function(
  key,
  ...
) {
    bod <- list(KeyId = key)
    out <- kmsHTTP(action = "DeleteKey", body = bod, ...)
    return(TRUE)
}
