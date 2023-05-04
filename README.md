
# Git Commit Signing

## gitsign

```bash
git verify-commit HEAD
tlog index: 19705860
gitsign: Signature made using certificate ID 0x4c3e220e44f747df6ac50eaf7fe7435c962e4aa4 | CN=sigstore-intermediate,O=sigstore.dev
gitsign: Good signature from [james.strong@chainguard.dev]
Validated Git signature: true
Validated Rekor entry: true
```

You can use search.sigstore.dev to view the entries about the commit sha 

Log Index  https://search.sigstore.dev/?logIndex=19705860

Commit sha https://search.sigstore.dev/?commitSha=2554b88e259b787db742abcaede8c4ccd05bd5ae

## Inspecting Commit Signatures Locally 

Output information about the certificate used for signing 
```bash
git cat-file commit HEAD | sed -n '/BEGIN/, /END/p' | sed 's/^ //g' | sed 's/gpgsig //g' | sed 's/SIGNED MESSAGE/PKCS7/g' | openssl pkcs7 -print -print_certs -text
```

gitsign show will print an in-toto style predicate for the specified revision.

```bash
gitsign show
```

```json
{
	"_type": "https://in-toto.io/Statement/v0.1",
	"predicateType": "gitsign.sigstore.dev/predicate/git/v0.1",
	"subject": [{
		"name": "git@github.com:chainguard-dev/chainguard-weaveworks-gitops-demo.git",
		"digest": {
			"sha1": "2554b88e259b787db742abcaede8c4ccd05bd5ae"
		}
	}],
	"predicate": {
		"source": {
			"tree": "d7fa76b38aa4f5d315632ee9524d758c2d117844",
			"parents": [
				"8912f18bbf775ea516ab7586eba03230bbc31ca7"
			],
			"author": {
				"name": "James Strong",
				"email": "james.strong@chainguard.dev",
				"date": "2023-05-04T15:18:56-04:00"
			},
			"committer": {
				"name": "James Strong",
				"email": "james.strong@chainguard.dev",
				"date": "2023-05-04T15:18:56-04:00"
			},
			"message": "add build and scans in makefile\n\nSigned-off-by: James Strong \u003cjames.strong@chainguard.dev\u003e\n"
		},
		"signature": "-----BEGIN SIGNED MESSAGE-----\nMIIENQYJKoZIhvcNAQcCoIIEJjCCBCICAQExDTALBglghkgBZQMEAgEwCwYJKoZI\nhvcNAQcBoIIC1zCCAtMwggJaoAMCAQICFGVErAp5dRhDhOFvXmLVOVYwDH5aMAoG\nCCqGSM49BAMDMDcxFTATBgNVBAoTDHNpZ3N0b3JlLmRldjEeMBwGA1UEAxMVc2ln\nc3RvcmUtaW50ZXJtZWRpYXRlMB4XDTIzMDUwNDE5MTkwMVoXDTIzMDUwNDE5Mjkw\nMVowADBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABPTjCuOE2UCZUGr6pOevYu51\nx6+Ur3eVcabCnk93zX3bpHUC6+ViudqHm9ay+k8ddJJ87gL5k5KLDhmSfC72M1ej\nggF5MIIBdTAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYD\nVR0OBBYEFJipt8y6q+EMoP1yT8bkKp67FSDQMB8GA1UdIwQYMBaAFN/T6c9WJBGW\n+ajY6ShVosYuGGQ/MCkGA1UdEQEB/wQfMB2BG2phbWVzLnN0cm9uZ0BjaGFpbmd1\nYXJkLmRldjApBgorBgEEAYO/MAEBBBtodHRwczovL2FjY291bnRzLmdvb2dsZS5j\nb20wKwYKKwYBBAGDvzABCAQdDBtodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20w\ngYoGCisGAQQB1nkCBAIEfAR6AHgAdgDdPTBqxscRMmMZHhyZZzcCokpeuN48rf+H\ninKALynujgAAAYfoNBu9AAAEAwBHMEUCIAngMRNNJAwbAqDQExc3k8D3JgX9K5K6\nRbtLHZDy5wi5AiEA5G0Yd9S+ed6/ULbt461FSkxZYqYHvgf453qIt05yPkwwCgYI\nKoZIzj0EAwMDZwAwZAIwRTvaGQkaVwklDe26C/TjgbdNdQnSxYkMqZ41xyOLbJY8\nyDXLxScNrDpdlSNYQ92iAjBxzLNM09a9fTA3clE9W8M22iAR7dz0eMbILOBY4LMc\nspP0Lv6quowGghNo81ZuZQsxggEkMIIBIAIBATBPMDcxFTATBgNVBAoTDHNpZ3N0\nb3JlLmRldjEeMBwGA1UEAxMVc2lnc3RvcmUtaW50ZXJtZWRpYXRlAhRlRKwKeXUY\nQ4Thb15i1TlWMAx+WjALBglghkgBZQMEAgGgaTAYBgkqhkiG9w0BCQMxCwYJKoZI\nhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA1MDQxOTE5MDFaMC8GCSqGSIb3DQEJ\nBDEiBCCHCmB38DJIBBI0lb2ibtdKp5O0yk49XeohbsUbra9NTjAKBggqhkjOPQQD\nAgRGMEQCIEsWjSlNu38vn19ni+OztwIBS8SA9cGUpbLIeKOdHhcMAiBm9FL/6KH3\nA4ET5SgBEkEVrgbLjLy0n1sBNTzPnhNUtQ==\n-----END SIGNED MESSAGE-----\n",
		"signer_info": [{
			"attributes": "MWkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwNTA0MTkxOTAxWjAvBgkqhkiG9w0BCQQxIgQghwpgd/AySAQSNJW9om7XSqeTtMpOPV3qIW7FG62vTU4=",
			"certificate": "-----BEGIN CERTIFICATE-----\nMIIC0zCCAlqgAwIBAgIUZUSsCnl1GEOE4W9eYtU5VjAMflowCgYIKoZIzj0EAwMw\nNzEVMBMGA1UEChMMc2lnc3RvcmUuZGV2MR4wHAYDVQQDExVzaWdzdG9yZS1pbnRl\ncm1lZGlhdGUwHhcNMjMwNTA0MTkxOTAxWhcNMjMwNTA0MTkyOTAxWjAAMFkwEwYH\nKoZIzj0CAQYIKoZIzj0DAQcDQgAE9OMK44TZQJlQavqk569i7nXHr5Svd5VxpsKe\nT3fNfdukdQLr5WK52oeb1rL6Tx10knzuAvmTkosOGZJ8LvYzV6OCAXkwggF1MA4G\nA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUmKm3\nzLqr4Qyg/XJPxuQqnrsVINAwHwYDVR0jBBgwFoAU39Ppz1YkEZb5qNjpKFWixi4Y\nZD8wKQYDVR0RAQH/BB8wHYEbamFtZXMuc3Ryb25nQGNoYWluZ3VhcmQuZGV2MCkG\nCisGAQQBg78wAQEEG2h0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbTArBgorBgEE\nAYO/MAEIBB0MG2h0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbTCBigYKKwYBBAHW\neQIEAgR8BHoAeAB2AN09MGrGxxEyYxkeHJlnNwKiSl643jyt/4eKcoAvKe6OAAAB\nh+g0G70AAAQDAEcwRQIgCeAxE00kDBsCoNATFzeTwPcmBf0rkrpFu0sdkPLnCLkC\nIQDkbRh31L553r9Qtu3jrUVKTFlipge+B/jneoi3TnI+TDAKBggqhkjOPQQDAwNn\nADBkAjBFO9oZCRpXCSUN7boL9OOBt011CdLFiQypnjXHI4tsljzINcvFJw2sOl2V\nI1hD3aICMHHMs0zT1r19MDdyUT1bwzbaIBHt3PR4xsgs4Fjgsxyyk/Qu/qq6jAaC\nE2jzVm5lCw==\n-----END CERTIFICATE-----\n"
		}]
	}
}
```

Chainguard Enforce for git

https://edu.chainguard.dev/chainguard/chainguard-enforce/chainguard-enforce-github/getting-started-enforce-github/

[How to install Chainguard Enforce for Git](https://edu.chainguard.dev/chainguard/chainguard-enforce/chainguard-enforce-github/install-enforce-github/

leos change
