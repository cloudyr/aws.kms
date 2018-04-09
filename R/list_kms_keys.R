#' @title List Encryption Keys
#' @description List encryption keys in KMS
#' @param n An integer specifying a number of keys to return (for pagination).
#' @param marker A pagination marker.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @seealso \code{\link{get_kms_key}}, \code{\link{create_kms_key}}, \code{\link{delete_kms_key}}
#' @export
list_kms_keys <-
function(
  n = 100,
  marker = NULL,
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
    out <- kmsHTTP(action = "ListKeys", body = bod, ...)
    structure(out$Keys, KeyCount = out$KeyCount, Truncated = out$Truncated)
}
