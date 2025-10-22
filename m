Return-Path: <linux-s390+bounces-14099-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99DBFB576
	for <lists+linux-s390@lfdr.de>; Wed, 22 Oct 2025 12:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ACC18823C9
	for <lists+linux-s390@lfdr.de>; Wed, 22 Oct 2025 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5032038D;
	Wed, 22 Oct 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf+J0OUs"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E831DDB9
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128015; cv=none; b=tPKb6r5W+kX1t+NkMg7P+zSD26uyy1qq1S9+YTrm0sjosxnivcq5eBnnkJxMKFAzd1yFA1sRcgs+ZG4mdic16g8WHff6ksjEp6vIqOxJ9ivZfEi82wwz9tFYR41S13wRZVYC7Gwo3Atk+BlFssj/ZeGq9qzKtDsz0LZpkvfzSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128015; c=relaxed/simple;
	bh=xbleyjew/gUw5tjiH+F/GM5sPSqPUuGp5zFrXdHnEss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+sHGelqmfaYz/nKiwrzDVUlJkmiJnbAYYLm8STmGCB5bqZajeWJsnIsm2FJ8mksj8XLXANL2ulzMIwt/hMRFko39c6rZ8Zz59eHLFsxi3j+zavmb1y6VbG0TObt1XIInY5cLURd19JN6NYU0Ww5l7FPi2tt6o2rlNfrfQFIK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf+J0OUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E09C4CEF5
	for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761128015;
	bh=xbleyjew/gUw5tjiH+F/GM5sPSqPUuGp5zFrXdHnEss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cf+J0OUsUIRcsHSBwhz7YYf0Z9ymKDK8GA1J6sql1jQu86YEQyfe66TD9dRlWn0fJ
	 QxrInwySwhAi0o5kYZrKes3WJ2nzRGBOCd7FwAdipREv5jRGCRMV3IUUimULjKLnfl
	 +Z0mdXVCUyzfK5up5HUbAFqPGJZcQ8OFOYfLsrPTmYSAcZjplbwcIg7YbDT8uyTR4Z
	 i/IZKEQtk83EbTkiPASU5XBSDqduHq4NPrpPw2voDdoZ/fvNbX6Xt0yPJqXlVV0nHy
	 lzJCtpmGOXU1EZV5iqntyALSeMSBpqBto9lXNShOBD0OXh5Fn5LIZU6quA5krtgF0j
	 GJ74B0vbZiqsQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59093864727so8049391e87.3
        for <linux-s390@vger.kernel.org>; Wed, 22 Oct 2025 03:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi0Vpt85iVsqi8sFAN/mPnkQ6bKIH59BG7RciYAKE6JJfIcAOhrB39y/2UtvlApuKGw0+R+SRtWUZm@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/Py+4xgxoa8nFUXqxP6rq9cZYfDqPmOIvD+nZs1EbDxESwqd
	PQyX+4LOr4qly5qh57NQDDfJKtIH5o9FiTHa0/WZB7O1xQbKUAWve1erGJBjlIq/6FxB51BnK0g
	9VZvSz36VrQyMj8sHZ98c+msZ8PPBGKc=
X-Google-Smtp-Source: AGHT+IFcCPrNwnq8tqyu26uoCns+CxnDTAM88jzdNDUEvsfOGixRrsmaAiH98/VG4HRDwveCRetRp7qwt02Fdgsnfd0=
X-Received: by 2002:a05:6512:159b:b0:55f:6fb4:e084 with SMTP id
 2adb3069b0e04-591d85739edmr7396384e87.50.1761128013726; Wed, 22 Oct 2025
 03:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020005038.661542-1-ebiggers@kernel.org>
In-Reply-To: <20251020005038.661542-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 22 Oct 2025 12:13:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEh=nS+pFgJUm5Vsyk1fMvY0dJNjLzA90Zj4AQPrD5ZYg@mail.gmail.com>
X-Gm-Features: AS18NWDkFNpIn7aOJ7I-K06jIqbriS-x6sjlQuJbYrgZlUVLWfy8F6r6U1x3XZ0
Message-ID: <CAMj1kXEh=nS+pFgJUm5Vsyk1fMvY0dJNjLzA90Zj4AQPrD5ZYg@mail.gmail.com>
Subject: Re: [PATCH 00/17] SHA-3 library
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 02:53, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series is targeting libcrypto-next.  It can also be retrieved from:
>
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git sha3-lib-v1
>
> This series builds on the first 5 patches of David's v6 series
> (https://lore.kernel.org/r/20251017144311.817771-1-dhowells@redhat.com),
> which I've included unmodified as the initial patches.  The remaining
> patches improve the SHA-3 library, for example by simplifying the API
> and migrating the existing arm64 and s390-optimized SHA-3 code into the
> library.  The last patch reimplements the sha3-* crypto_shash algorithms
> on top of the library.
>
> If the s390 folks could re-test the s390 optimized SHA-3 code, that
> would be helpful.  QEMU doesn't support the instructions it uses.
>
> David Howells (5):
>   s390/sha3: Rename conflicting functions
>   arm64/sha3: Rename conflicting functions
>   lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128,
>     SHAKE256
>   lib/crypto: Move the SHA3 Iota transform into the single round
>     function
>   lib/crypto: Add SHA3 kunit tests
>
> Eric Biggers (12):
>   lib/crypto: sha3: Fix libsha3 build condition
>   lib/crypto: sha3: Use appropriate conversions in
>     sha3_keccakf_generic()
>   lib/crypto: sha3: Drop unfinished SHAKE support from
>     gen-hash-testvecs.py
>   lib/crypto: sha3: Consistently use EXPORT_SYMBOL_GPL
>   lib/crypto: sha3: Replace redundant ad-hoc test with FIPS test
>   lib/crypto: sha3: Simplify the API
>   lib/crypto: sha3: Document one-shot functions in header and improve
>     docs
>   crypto: arm64/sha3 - Update sha3_ce_transform() to prepare for library
>   lib/crypto: arm64/sha3: Migrate optimized code into library
>   lib/crypto: s390/sha3: Migrate optimized code into library
>   crypto: jitterentropy - use default sha3 implementation
>   crypto: sha3 - Reimplement using library API
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

