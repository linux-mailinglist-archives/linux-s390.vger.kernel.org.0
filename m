Return-Path: <linux-s390+bounces-14023-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D56BF08F1
	for <lists+linux-s390@lfdr.de>; Mon, 20 Oct 2025 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F794F223C
	for <lists+linux-s390@lfdr.de>; Mon, 20 Oct 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF32F90DE;
	Mon, 20 Oct 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faDp8PfL"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8872F9C2A
	for <linux-s390@vger.kernel.org>; Mon, 20 Oct 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956431; cv=none; b=jHfG37q9z8NLrb27UrJmQpT9B/Eh8lf5i+/3rszy4qQSP6OvZzAK4IX+bRN+S87OH2RrOSV/ahY2M/6fz9jmCs97PVoZmzKBAJ1u3hzQqafCOFvWguw5UkCKCXR3AHmOcpe+kAQ7Yz5NZlMqdU3HPKDBfw8Q9dMAPq6hlCSoNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956431; c=relaxed/simple;
	bh=QIfJvWLwwRaiRLgrna29KMjaHzNc87zIwmeMVe/lkCU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=SVSSsZlyBT5Mi9MboX/jle6Areo9yyJ/2tIZ5S8dem7LV19QXq0UTyMLCV0oaeuRmV28TOmICy3WDY1VP/6ukWAytrYTz6jRglTyHwJuW9iw26y1EyaTJRP8bvbwPbatIxgiegIK3bVmTEJNZiK5ulWrKBc3FqDWXt564S2+C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faDp8PfL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760956428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Pa5+u9QjFpdCt3QGlBVROCbgssonhS9xjrxu/nfbTI=;
	b=faDp8PfLL73S3Y2Rj5YwZy1qnK1lB0ffWgvOOmXtKg5hkUy7YKBfpl1F3XqyyC8led7PKd
	IbdWeO8A5fA74V3UBIGdIVXEqZgxSHLKh2IiCo41VVGLkn8fsTX3aDzXYOH01iDVRFd1E9
	8OmauR4DhDfcBWB8mzHIqvPykG5rGYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-GDfMxLa6PWCu3OjmYdRDgg-1; Mon,
 20 Oct 2025 06:33:43 -0400
X-MC-Unique: GDfMxLa6PWCu3OjmYdRDgg-1
X-Mimecast-MFC-AGG-ID: GDfMxLa6PWCu3OjmYdRDgg_1760956421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6701E18009C2;
	Mon, 20 Oct 2025 10:33:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FADD30001BC;
	Mon, 20 Oct 2025 10:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251020005038.661542-12-ebiggers@kernel.org>
References: <20251020005038.661542-12-ebiggers@kernel.org> <20251020005038.661542-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, linux-crypto@vger.kernel.org,
    Ard Biesheuvel <ardb@kernel.org>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
    linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/17] lib/crypto: sha3: Simplify the API
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1062181.1760956416.1@warthog.procyon.org.uk>
Date: Mon, 20 Oct 2025 11:33:36 +0100
Message-ID: <1062182.1760956416@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> Instead of having separate types and functions for each of the six SHA-3
> algorithms, instead divide them into two groups: the digests and the
> XOFs.  The digests use sha3_ctx and the XOFs use shake_ctx.  The
> internal context is now called __sha3_ctx.

Please roll changes into the original patches rather than posting them with a
set of "fixes" and add a Co-developed-by tag for yourself.  Or if you want
your authorship on your changes, just switch the Author to yourself and put a
note in the changelog noting that you modified it from what I posted.

> +/** Context for SHA3-224, SHA3-256, SHA3-384, or SHA3-512 */
> +struct sha3_ctx {
> +	struct __sha3_ctx	ctx;
> +	u8			digest_size;	/* Digest size in bytes */
> +};

Don't do that.  That expands the context by an extra word when there's spare
space in __sha3_ctx.  If you go with the separate types, then this field is
redundant.  Actually, I lean slightly towards passing in the desired digest
length to sha3_*final() and doing a WARN if it doesn't match.

> +static inline void sha3_zeroize_ctx(struct sha3_ctx *ctx)

sha3_zero_ctx() please if you don't like "sha3_clear_ctx".  "zero" is a
perfectly usable as verb in itself.

> +/** Zeroize a shake_ctx.  Call this after the last squeeze. */

/**
 * shake_zero_ctx - Clear a shake_ctx.
 * @ctx: The context to clear.
 * 
 * Clear the context for a shake XOF.  Call after the last squeeze.
 */

Something like this, please.

David


