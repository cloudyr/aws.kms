#' @rdname keys
#' @title Create/Update/Retrieve/Delete Encryption Key
#' @description Create/update/retrieve/delete a KMS encryption key
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param delay An integer specifying a number of delays to wait before deleting key. Minimum 7 and maximum 30.
#' @param description Optionally, a character string describing the key. This can be updated later using \code{update_kms_key}. An alias for the key, which can be used in lieu of the KeyId in subsequent calls can be set with \code{\link{create_kms_alias}}.
#' @param origin A character string specifying the origin. Default is \dQuote{AWS_KMS}. If \dQuote{EXTERNAL}, use \code{\link{put_kms_material}} to add a key created using other infrastructure. See \url{https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html} for details.
#' @param usage Ignored.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @return \code{create_kms_key} and \code{get_kms_key} return a list of class \dQuote{aws_kms_key}. \code{delete_kms_key} and \code{undelete_kms_key} return a logical.
#' @examples
#' \dontrun{
#'   # create key
#'   k <- create_kms_key(description = "example")
#'   
#'   # get key
#'   get_kms_key(k)
#'   
#'   # delete in 30 days
#'   delete_kms_key(k, delay = 30)
#' }
#' @seealso \code{\link{list_kms_keys}}, \code{\link{create_kms_alias}}, \code{\link{disable_kms_key}}, \code{\link{encrypt}}
#' @export
create_kms_key <-
function(
  description = NULL,
  origin = c("AWS_KMS", "EXTERNAL"),
  usage = "ENCRYPT_DECRYPT",
  ...
) {
    bod <- list()
    bod[["Origin"]] <- match.arg(toupper(origin), origin)
    if (!is.null(description)) {
        bod[["Description"]] <- description
    }
    out <- kmsHTTP(action = "CreateKey", body = bod, ...)
    structure(out$KeyMetadata, class = "aws_kms_key")
}

#' @rdname keys
#' @export
update_kms_key <-
function(
  key,
  description,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key), Description = description)
    out <- kmsHTTP(action = "UpdateKeyDescription", body = bod, ...)
    return(TRUE)
}

#' @rdname keys
#' @export
get_kms_key <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "DescribeKey", body = bod, ...)
    structure(out$KeyMetadata, class = "aws_kms_key")
}

#' @rdname keys
#' @export
delete_kms_key <-
function(
  key,
  delay = 7,
  ...
) {
    stopifnot(delay >= 7 && delay <= 30)
    bod <- list(KeyId = get_kms_keyid(key), PendingWindowInDays = delay)
    out <- kmsHTTP(action = "ScheduleKeyDeletion", body = bod, ...)
    return(TRUE)
}

#' @rdname keys
#' @export
undelete_kms_key <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "CancelKeyDeletion", body = bod, ...)
    return(TRUE)
}
