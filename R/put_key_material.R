#' @rdname key_material
#' @title Put/Delete KMS Key Material
#' @description Manage key material for \dQuote{external} keys.
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param material A character string specifying the base64-encoded key material (encrypted according to parameters returned by \code{get_material_parameters}).
#' @param token A character string returned in \code{get_material_parameters()$ImportToken}.
#' @param expires Optionally, a logical indicating whether the key material expires. If \code{TRUE} (the default), \code{valid_to} is required.
#' @param valid_to Optionally (if \code{expires = TRUE}), a number specifying when the key material expires.
#' @param algorithm A character string specifying an encryption algorithm used to encrypt the key material.
#' @param spec Ignored.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @details \code{put_kms_material} adds key material to an \dQuote{external} KMS key, which can be created using \code{create_kms_key}. The import requires \code{delete_kms_material} deletes the imported material (but not the key itself).
#' @references
#' \url{docs.aws.amazon.com/kms/latest/developerguide/importing-keys-encrypt-key-material.html}
#' @seealso \code{\link{create_kms_key}}
#' @export
put_kms_material <-
function(
  key,
  material,
  token,
  expires = TRUE,
  valid_to = NULL,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key),
                EncryptedKeyMaterial = material,
                ImportToken = token)
    if (isTRUE(expires)) {
        bod[["ExpirationModel"]] <- "KEY_MATERIAL_EXPIRES"
        bod[["ValidTo"]] <- valid_to
    } else {
        bod[["ExpirationModel"]] <- "KEY_MATERIAL_DOES_NOT_EXPIRE"
    }
    out <- kmsHTTP(action = "ImportKeyMaterial", body = bod, ...)
    return(out)
}

#' @rdname key_material
#' @export
delete_kms_material <-
function(
  key,
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key))
    out <- kmsHTTP(action = "DeleteImportedKeyMaterial", body = bod, ...)
    return(TRUE)
}

#' @rdname key_material
#' @export
get_material_parameters <-
function(
  key,
  algorithm = c("RSAES_PKCS1_V1_5", "RSAES_OAEP_SHA_1", "RSAES_OAEP_SHA_256"),
  spec = "RSA_2048",
  ...
) {
    bod <- list(KeyId = get_kms_keyid(key),
                WrappingAlgorithm = match.arg(algorithm))#,
                #WrappingKeySpec = match.arg(spec))
    out <- kmsHTTP(action = "DeleteImportedKeyMaterial", body = bod, ...)
    return(TRUE)
}
