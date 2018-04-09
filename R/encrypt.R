#' @rdname encrypt
#' @title Perform encryption/decryption
#' @description Encrypt plain text into ciphertext, or the reverse
#' @param text For \code{encrypt}, a character string specifying up to 4 kilobytes of data to be encrypted using the specified key. For \code{decrypt}, ciphertext of maximum 6144 bytes.
#' @param key A character string specifying a key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \dQuote{alias/}.
#' @param encode A logical specifying whether to base 64 encode \code{text}.
#' @param \dots Additional arguments passed to \code{\link{kmsHTTP}}.
#' @details \code{encrypt} encrypts source text using a KMS key. \code{decrypt} reverses this process using the same key. \code{reencrypt} reencrypts an (encrypted) ciphertext using a new key.
#' @seealso \code{\link{create_kms_key}}, \code{\link{list_kms_keys}}, \code{\link{generate_blob}}
#' @importFrom base64enc base64encode
#' @export
encrypt <-
function(
  text,
  key,
  encode = TRUE,
  ...
) {
    bod <- list(KeyId = key)
    if (isTRUE(encode)) {
        bod$Plaintext <- base64enc::base64encode(text)
    } else {
        bod$Plaintext <- text
    }
    out <- kmsHTTP(action = "Encrypt", body = bod, ...)
    return(out)
}

#' @rdname encrypt
#' @export
decrypt <-
function(
  text,
  key,
  encode = TRUE,
  ...
) {
    bod <- list(KeyId = key)
    if (isTRUE(encode)) {
        bod$CiphertextBlob <- base64enc::base64encode(text)
    } else {
        bod$CiphertextBlob <- text
    }
    out <- kmsHTTP(action = "Decrypt", body = bod, ...)
    return(out)
}

#' @rdname encrypt
#' @export
reencrypt <-
function(
  text,
  key,
  encode = TRUE,
  ...
) {
    bod <- list(DestinationKeyId = key)
    if (isTRUE(encode)) {
        bod$CiphertextBlob <- base64enc::base64encode(text)
    } else {
        bod$CiphertextBlob <- text
    }
    out <- kmsHTTP(action = "ReEcrypt", body = bod, ...)
    return(out)
}
