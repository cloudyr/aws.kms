#' @rdname alias
#' @title Create/Delete KMS Key Alias
#' @description Manage KMS key aliases.
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param alias A character string specifying an alias name.
#' @param n For \code{list_kms_alises}, an integer specifying a number of keys to return (for pagination).
#' @param marker For \code{list_kms_alises}, a pagination marker.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @details \code{create_kms_alias} creates an alias for KMS key, which can be used in place of the KeyId or ARN. A given key can have multiple aliases. \code{delete_kms_alias} deletes an named alias. \code{update_kms_alias} reassigns an alias to a new key.
#' @seealso \code{\link{create_kms_key}}, \code{\link{delete_kms_key}}, \code{\link{encrypt}}
#' @export
create_kms_alias <-
function(
  key,
  alias,
  ...
) {
    bod <- list(AliasName = alias, TargetKeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "CreateAlias", body = bod, ...)
    return(out)
}

#' @rdname alias
#' @export
delete_kms_alias <-
function(
  alias,
  ...
) {
    bod <- list(AliasName = alias)
    out <- kmsHTTP(action = "DeleteAlias", body = bod, ...)
    return(out)
}

#' @rdname alias
#' @export
update_kms_alias <-
function(
  key,
  alias,
  ...
) {
    bod <- list(AliasName = alias, TargetKeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "UpdateAlias", body = bod, ...)
    return(out)
}

#' @rdname alias
#' @export
list_kms_aliases <-
function(
  n,
  marker,
  ...
) {
    bod <- list()
    if (!is.null(marker)) {
        bod$Marker <- marker
    }
    if (!is.null(n)) {
        if (n < 1 || n > 10000) {
            stop("'n' must be between 1 and 10000")
        }
        bod$Limit <- n
    }
    out <- kmsHTTP(action = "ListAliases", body = bod, ...)
    return(out)
}
